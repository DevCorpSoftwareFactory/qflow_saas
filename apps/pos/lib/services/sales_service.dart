import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

import '../data/local/database.dart';
import 'stock_service.dart';
import 'dto/create_sale_dto.dart';

/// Service for processing sales with atomic transactions.
/// Offline-first: All operations execute locally with sync queue.
class SalesService {
  final AppDatabase _db;
  final StockService _stockService;
  final _uuid = const Uuid();

  SalesService({
    required AppDatabase database,
    required StockService stockService,
  }) : _db = database,
       _stockService = stockService;

  /// Create a sale with offline atomic transaction.
  /// All steps execute within a single Drift transaction.
  Future<LocalSale> createSale(CreateSaleDto dto, String tenantId) async {
    return _db.transaction(() async {
      // Step 1: Validate stock for ALL items
      await _validateAllItems(dto.items, dto.branchId);

      // Step 2: Calculate totals
      final totals = _calculateTotals(dto);

      // Step 3: Create Sale header
      final saleId = _uuid.v4();
      final sale = LocalSalesCompanion.insert(
        id: saleId,
        tenantId: tenantId,
        branchId: dto.branchId,
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

      // Step 4: Process each item
      for (final item in dto.items) {
        await _processSaleItem(saleId, item, dto.branchId, tenantId);
      }

      // Step 5: Create Cash Movement
      await _createCashMovement(saleId, totals.totalAmount, dto, tenantId);

      // Step 6: Add to Sync Queue
      await _addToSyncQueue(saleId, tenantId);

      // Return the created sale
      return (_db.select(
        _db.localSales,
      )..where((s) => s.id.equals(saleId))).getSingle();
    });
  }

  /// Validate stock for all items before processing.
  Future<void> _validateAllItems(
    List<SaleItemDto> items,
    String branchId,
  ) async {
    for (final item in items) {
      await _stockService.checkAvailability(
        variantId: item.variantId,
        branchId: branchId,
        quantity: item.quantity,
        isOnline: false, // Always offline validation first
      );
    }
  }

  /// Calculate sale totals.
  _SaleTotals _calculateTotals(CreateSaleDto dto) {
    double subtotal = 0;

    for (final item in dto.items) {
      final itemSubtotal = item.unitPrice * item.quantity;
      final discount = itemSubtotal * ((item.discountPercent ?? 0) / 100);
      subtotal += itemSubtotal - discount;
    }

    // 19% IVA for Colombia
    const taxRate = 0.19;
    final taxAmount = subtotal * taxRate;
    final totalAmount = subtotal + taxAmount - (dto.discountAmount ?? 0);

    return _SaleTotals(
      subtotal: subtotal,
      taxAmount: taxAmount,
      totalAmount: totalAmount,
    );
  }

  /// Process a single sale item.
  Future<void> _processSaleItem(
    String saleId,
    SaleItemDto item,
    String branchId,
    String tenantId,
  ) async {
    final itemId = _uuid.v4();

    // Calculate item subtotal
    final itemSubtotal =
        item.unitPrice *
        item.quantity *
        (1 - (item.discountPercent ?? 0) / 100);

    // Create SaleItem
    final saleItem = LocalSaleItemsCompanion.insert(
      id: itemId,
      saleId: saleId,
      variantId: item.variantId,
      lotId: Value(item.lotId),
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      costPrice: const Value(null), // Will be filled from lot if available
      discountPercent: Value(item.discountPercent ?? 0),
      subtotal: itemSubtotal,
      synced: const Value(false),
    );
    await _db.into(_db.localSaleItems).insert(saleItem);

    // Create Inventory Movement (Kardex - IMMUTABLE)
    final movementId = _uuid.v4();
    final movement = LocalInventoryMovementsCompanion.insert(
      id: movementId,
      tenantId: tenantId,
      branchId: branchId,
      variantId: item.variantId,
      lotId: Value(item.lotId),
      movementType: MovementType.sale,
      quantity: -item.quantity, // Negative for outbound
      synced: const Value(false),
      localId: movementId,
    );
    await _db.into(_db.localInventoryMovements).insert(movement);
  }

  /// Create cash movement for the sale.
  Future<void> _createCashMovement(
    String saleId,
    double amount,
    CreateSaleDto dto,
    String tenantId,
  ) async {
    final movementId = _uuid.v4();
    final cashMovement = LocalCashMovementsCompanion.insert(
      id: movementId,
      tenantId: tenantId,
      cashSessionId: Value(dto.cashSessionId),
      movementType: CashMovementType.income,
      category: Value(CashMovementCategory.salesCash),
      amount: amount,
      concept: 'Venta $saleId',
      synced: const Value(false),
      localId: movementId,
    );
    await _db.into(_db.localCashMovements).insert(cashMovement);
  }

  /// Add sale to sync queue for later synchronization.
  Future<void> _addToSyncQueue(String saleId, String tenantId) async {
    final queueEntry = SyncQueueCompanion.insert(
      entityType: 'sale',
      entityId: saleId,
      operation: 'create',
      payload: '{"saleId": "$saleId", "tenantId": "$tenantId"}',
    );
    await _db.into(_db.syncQueue).insert(queueEntry);
  }
}

/// Helper class for sale totals
class _SaleTotals {
  final double subtotal;
  final double taxAmount;
  final double totalAmount;

  _SaleTotals({
    required this.subtotal,
    required this.taxAmount,
    required this.totalAmount,
  });
}
