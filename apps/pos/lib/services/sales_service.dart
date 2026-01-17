import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'dart:convert';

import '../data/local/database.dart';
import 'stock_service.dart';
import 'fifo_service.dart';
import 'cash_session_service.dart';
import 'dto/create_sale_dto.dart';

/// Service for processing sales with atomic transactions.
/// Offline-first: All operations execute locally with sync queue.
///
/// Implements:
/// - RF-001: Stock changes via inventory_movements
/// - RF-002: Updates current_quantity via lot updates
/// - RF-003: Immutable inventory_movements
/// - RF-005: Links sales_details to specific lot_id (FIFO)
/// - RF-006: Uses price from price_list_items (passed in DTO)
class SalesService {
  final AppDatabase _db;
  final StockService _stockService;
  final FifoService _fifoService;
  final CashSessionService _cashSessionService;
  final _uuid = const Uuid();

  SalesService({
    required AppDatabase database,
    required StockService stockService,
    required FifoService fifoService,
    required CashSessionService cashSessionService,
  })  : _db = database,
        _stockService = stockService,
        _fifoService = fifoService,
        _cashSessionService = cashSessionService;

  /// Create a sale with offline atomic transaction.
  /// All steps execute within a single Drift transaction.
  ///
  /// Flow:
  /// 1. Validate stock for ALL items
  /// 2. Calculate totals
  /// 3. Create Sale header
  /// 4. Process each item with FIFO lot consumption
  /// 5. Register payments
  /// 6. Create Cash Movements (for cash payments)
  /// 7. Add to Sync Queue
  Future<SaleResult> createSale(CreateSaleDto dto, String tenantId) async {
    return _db.transaction(() async {
      // Step 1: Validate stock for ALL items
      await _validateAllItems(dto.items, dto.branchId);

      // Step 2: Calculate totals
      final totals = _calculateTotals(dto);

      // Step 3: Create Sale header
      final saleId = _uuid.v4();
      final saleNumber = await _generateSaleNumber(tenantId);

      final sale = LocalSalesCompanion.insert(
        id: saleId,
        tenantId: tenantId,
        branchId: dto.branchId,
        saleNumber: Value(saleNumber),
        customerId: Value(dto.customerId),
        cashierId: dto.cashierId,
        subtotal: Value(totals.subtotal),
        taxAmount: Value(totals.taxAmount),
        discountAmount: Value(dto.discountAmount ?? 0),
        totalAmount: Value(totals.totalAmount),
        status: Value(SaleStatus.completed),
        saleType: Value(SaleType.retail),
        synced: const Value(false),
        localId: saleId,
      );
      await _db.into(_db.localSales).insert(sale);

      // Step 4: Process each item with FIFO
      final processedItems = <ProcessedSaleItem>[];
      for (final item in dto.items) {
        final processed = await _processSaleItemWithFifo(
          saleId: saleId,
          item: item,
          branchId: dto.branchId,
          tenantId: tenantId,
        );
        processedItems.addAll(processed);
      }

      // Step 5: Register payments
      await _registerPayments(saleId, dto.payments, tenantId);

      // Step 6: Update Cash Session (for cash payments)
      double totalCashAmount = 0;
      for (final payment in dto.payments) {
        if (payment.method == PaymentMethod.cash) {
          totalCashAmount += payment.amount;
        }
      }

      // Step 6.1: Update cash session if one is active
      if (dto.cashSessionId != null && totalCashAmount > 0) {
        await _cashSessionService.recordSaleInSession(
          sessionId: dto.cashSessionId!,
          cashAmount: totalCashAmount,
        );
      }

      // Step 7: Add to Sync Queue with full payload
      await _addToSyncQueue(saleId, tenantId, processedItems, dto.payments);

      // Return the created sale with details
      final createdSale = await (_db.select(_db.localSales)
            ..where((s) => s.id.equals(saleId)))
          .getSingle();

      return SaleResult(
        sale: createdSale,
        saleNumber: saleNumber,
        items: processedItems,
        totals: totals,
      );
    });
  }

  /// Validate stock for all items before processing.
  Future<void> _validateAllItems(
    List<SaleItemDto> items,
    String branchId,
  ) async {
    // Aggregate quantities by variant (in case same variant appears multiple times)
    final aggregated = <String, int>{};
    for (final item in items) {
      aggregated[item.variantId] =
          (aggregated[item.variantId] ?? 0) + item.quantity;
    }

    for (final entry in aggregated.entries) {
      await _stockService.checkAvailability(
        variantId: entry.key,
        branchId: branchId,
        quantity: entry.value,
        isOnline: false, // Always offline validation first
      );
    }
  }

  /// Calculate sale totals.
  SaleTotals _calculateTotals(CreateSaleDto dto) {
    double subtotal = 0;

    for (final item in dto.items) {
      final itemSubtotal = item.unitPrice * item.quantity;
      final discount = itemSubtotal * ((item.discountPercent ?? 0) / 100);
      subtotal += itemSubtotal - discount;
    }

    // 19% IVA for Colombia
    // 19% IVA for Colombia
    const taxRate = 0.19;
    // Discount reduces the taxable base
    final taxableBase = subtotal - (dto.discountAmount ?? 0);
    // Ensure taxable base is not negative
    final finalTaxableBase = taxableBase < 0 ? 0.0 : taxableBase;

    final taxAmount = finalTaxableBase * taxRate;
    final totalAmount = finalTaxableBase + taxAmount;

    return SaleTotals(
      subtotal: subtotal,
      taxAmount: taxAmount,
      totalAmount: totalAmount,
      taxRate: taxRate,
    );
  }

  /// Process a single sale item with FIFO lot consumption.
  /// May create multiple sale_items if quantity spans multiple lots.
  Future<List<ProcessedSaleItem>> _processSaleItemWithFifo({
    required String saleId,
    required SaleItemDto item,
    required String branchId,
    required String tenantId,
  }) async {
    // Get FIFO consumption plan
    final consumption = await _fifoService.consumeFifo(
      tenantId: tenantId,
      variantId: item.variantId,
      branchId: branchId,
      quantity: item.quantity,
      referenceType: 'sale',
      referenceId: saleId,
    );

    if (!consumption.success) {
      throw Exception('FIFO consumption failed: ${consumption.message}');
    }

    // Persist FIFO consumption (creates movements & updates lots)
    await _fifoService.persistFifoConsumption(
      tenantId: tenantId,
      branchId: branchId,
      variantId: item.variantId,
      consumption: consumption,
      referenceType: 'sale',
      referenceId: saleId,
    );

    // Create sale items for each lot consumed
    final processedItems = <ProcessedSaleItem>[];

    for (final lotConsumption in consumption.lotsConsumed) {
      final itemId = _uuid.v4();

      // Calculate proportional price for this lot's quantity
      final itemSubtotal = item.unitPrice *
          lotConsumption.quantityConsumed *
          (1 - (item.discountPercent ?? 0) / 100);

      // Create SaleItem linked to specific lot (RF-005)
      final saleItem = LocalSaleItemsCompanion.insert(
        id: itemId,
        saleId: saleId,
        variantId: item.variantId,
        lotId: Value(lotConsumption.lotId), // FIFO lot link
        quantity: lotConsumption.quantityConsumed,
        unitPrice: item.unitPrice,
        costPrice: Value(lotConsumption.unitCost), // From lot
        discountPercent: Value(item.discountPercent ?? 0),
        subtotal: itemSubtotal,
        synced: const Value(false),
      );
      await _db.into(_db.localSaleItems).insert(saleItem);

      processedItems.add(ProcessedSaleItem(
        itemId: itemId,
        variantId: item.variantId,
        lotId: lotConsumption.lotId,
        lotNumber: lotConsumption.lotNumber,
        quantity: lotConsumption.quantityConsumed,
        unitPrice: item.unitPrice,
        costPrice: lotConsumption.unitCost,
        subtotal: itemSubtotal,
      ));
    }

    return processedItems;
  }

  /// Register payments for the sale.
  Future<void> _registerPayments(
    String saleId,
    List<PaymentDto> payments,
    String tenantId,
  ) async {
    for (final payment in payments) {
      final paymentId = _uuid.v4();

      final salePayment = LocalSalePaymentsCompanion.insert(
        id: paymentId,
        saleId: saleId,
        tenantId: Value(tenantId),
        paymentMethod: payment.method,
        amount: payment.amount,
        reference: Value(payment.reference),
        cardLastFour: Value(payment.cardLastFour),
        synced: const Value(false),
        localId: paymentId,
      );

      await _db.into(_db.localSalePayments).insert(salePayment);
    }
  }

  /// Add sale to sync queue with full payload for later synchronization.
  Future<void> _addToSyncQueue(
    String saleId,
    String tenantId,
    List<ProcessedSaleItem> items,
    List<PaymentDto> payments,
  ) async {
    final payload = {
      'saleId': saleId,
      'tenantId': tenantId,
      'items': items
          .map((i) => {
                'itemId': i.itemId,
                'variantId': i.variantId,
                'lotId': i.lotId,
                'quantity': i.quantity,
                'unitPrice': i.unitPrice,
                'costPrice': i.costPrice,
                'subtotal': i.subtotal,
              })
          .toList(),
      'payments': payments
          .map((p) => {
                'method': p.method.name,
                'amount': p.amount,
                'reference': p.reference,
              })
          .toList(),
    };

    final queueEntry = SyncQueueCompanion.insert(
      entityType: 'sale',
      entityId: saleId,
      operation: 'create',
      payload: jsonEncode(payload),
    );
    await _db.into(_db.syncQueue).insert(queueEntry);
  }

  /// Generate a unique sale number for the day.
  Future<String> _generateSaleNumber(String tenantId) async {
    final now = DateTime.now();
    final datePrefix =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';

    // Count today's sales
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final count = await (_db.selectOnly(_db.localSales)
          ..addColumns([_db.localSales.id])
          ..where(_db.localSales.tenantId.equals(tenantId))
          ..where(_db.localSales.createdAt.isBiggerOrEqualValue(todayStart))
          ..where(_db.localSales.createdAt.isSmallerThanValue(todayEnd)))
        .get();

    final sequence = (count.length + 1).toString().padLeft(4, '0');
    return 'V$datePrefix-$sequence';
  }

  /// Cancel a sale (creates reversal movements).
  Future<void> cancelSale(String saleId, String userId, String reason) async {
    await _db.transaction(() async {
      // Update sale status
      await (_db.update(_db.localSales)..where((s) => s.id.equals(saleId)))
          .write(LocalSalesCompanion(
        status: const Value(SaleStatus.cancelled),
        notes: Value(reason),
        updatedAt: Value(DateTime.now()),
      ));

      // Get sale items
      final items = await (_db.select(_db.localSaleItems)
            ..where((i) => i.saleId.equals(saleId)))
          .get();

      // Create reversal inventory movements for each item
      for (final item in items) {
        if (item.lotId != null) {
          final movementId = _uuid.v4();
          final movement = LocalInventoryMovementsCompanion.insert(
            id: movementId,
            tenantId: item.tenantId ?? '',
            branchId: '', // Would need to get from sale
            variantId: item.variantId,
            lotId: Value(item.lotId),
            movementType: MovementType.returnCustomer,
            quantity: item.quantity, // Positive = return to stock
            referenceType: const Value('sale_cancel'),
            referenceId: Value(saleId),
            notes: Value('Anulación de venta: $reason'),
            synced: const Value(false),
            localId: movementId,
          );
          await _db.into(_db.localInventoryMovements).insert(movement);

          // Update lot quantity
          final lot = await (_db.select(_db.localInventoryLots)
                ..where((l) => l.id.equals(item.lotId!)))
              .getSingleOrNull();

          if (lot != null) {
            await (_db.update(_db.localInventoryLots)
                  ..where((l) => l.id.equals(item.lotId!)))
                .write(LocalInventoryLotsCompanion(
              currentQuantity: Value(lot.currentQuantity + item.quantity),
              status:
                  const Value(LotStatus.active), // Reactivate if was depleted
              updatedAt: Value(DateTime.now()),
            ));
          }
        }
      }

      // Add cancellation to sync queue
      final queueEntry = SyncQueueCompanion.insert(
        entityType: 'sale',
        entityId: saleId,
        operation: 'cancel',
        payload: jsonEncode({
          'saleId': saleId,
          'reason': reason,
          'cancelledBy': userId,
        }),
      );
      await _db.into(_db.syncQueue).insert(queueEntry);
    });
  }
}

/// Result of creating a sale.
class SaleResult {
  final LocalSale sale;
  final String saleNumber;
  final List<ProcessedSaleItem> items;
  final SaleTotals totals;

  const SaleResult({
    required this.sale,
    required this.saleNumber,
    required this.items,
    required this.totals,
  });
}

/// Processed sale item with lot information.
class ProcessedSaleItem {
  final String itemId;
  final String variantId;
  final String lotId;
  final String lotNumber;
  final int quantity;
  final double unitPrice;
  final double costPrice;
  final double subtotal;

  const ProcessedSaleItem({
    required this.itemId,
    required this.variantId,
    required this.lotId,
    required this.lotNumber,
    required this.quantity,
    required this.unitPrice,
    required this.costPrice,
    required this.subtotal,
  });

  /// Calculate margin for this item.
  double get margin => subtotal - (costPrice * quantity);
  double get marginPercent => subtotal > 0 ? (margin / subtotal) * 100 : 0;
}

/// Sale totals breakdown.
class SaleTotals {
  final double subtotal;
  final double taxAmount;
  final double totalAmount;
  final double taxRate;

  const SaleTotals({
    required this.subtotal,
    required this.taxAmount,
    required this.totalAmount,
    required this.taxRate,
  });
}
