import 'package:drift/drift.dart';

import '../data/local/database.dart';
import 'exceptions/stock_insufficient_exception.dart';

/// Result of consuming a lot partially or fully.
class LotConsumption {
  final String lotId;
  final String lotNumber;
  final int quantityConsumed;
  final double unitCost;
  final double totalCost;

  const LotConsumption({
    required this.lotId,
    required this.lotNumber,
    required this.quantityConsumed,
    required this.unitCost,
    required this.totalCost,
  });
}

/// Result of FIFO consumption operation.
class FifoConsumptionResult {
  final bool success;
  final List<LotConsumption> lotsConsumed;
  final int totalQuantityConsumed;
  final double totalCost;
  final String? message;

  const FifoConsumptionResult({
    required this.success,
    required this.lotsConsumed,
    required this.totalQuantityConsumed,
    required this.totalCost,
    this.message,
  });
}

/// Service for FIFO (First-In-First-Out) / FEFO (First-Expired-First-Out)
/// inventory consumption.
///
/// Based on RF-001, RF-002, RF-003, RF-005 constraints:
/// - RF-001: Stock changes via inventory_movements only
/// - RF-002: Never modify current_quantity directly
/// - RF-003: inventory_movements is IMMUTABLE
/// - RF-005: sales_details must link to specific lot_id
///
/// For perishable food products, we use FEFO (expiry_date first),
/// then FIFO (created_at) as tiebreaker.
class FifoService {
  final AppDatabase _db;

  FifoService({required AppDatabase database}) : _db = database;

  /// Get available lots for a variant in a branch, ordered by FEFO/FIFO.
  ///
  /// Order: expiry_date ASC NULLS LAST, then created_at ASC
  /// This ensures:
  /// 1. Products expiring soonest are sold first
  /// 2. Products without expiry date use creation date (true FIFO)
  Future<List<LocalInventoryLot>> getAvailableLots({
    required String variantId,
    required String branchId,
    int? minQuantity,
  }) async {
    final query = _db.select(_db.localInventoryLots)
      ..where((lot) => lot.variantId.equals(variantId))
      ..where((lot) => lot.branchId.equals(branchId))
      ..where((lot) => lot.status.equals('active'))
      ..where((lot) => lot.currentQuantity.isBiggerThanValue(0));

    // Get all matching lots
    final lots = await query.get();

    // Filter expired lots (expiry_date <= today)
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final validLots = lots.where((lot) {
      if (lot.expiryDate == null) return true;
      return lot.expiryDate!.isAfter(today);
    }).toList();

    // Sort by FEFO then FIFO
    validLots.sort((a, b) {
      // First by expiry_date (nulls last)
      if (a.expiryDate == null && b.expiryDate == null) {
        // Both null, sort by created_at
        return a.createdAt.compareTo(b.createdAt);
      }
      if (a.expiryDate == null) return 1; // a goes after b
      if (b.expiryDate == null) return -1; // b goes after a

      final expiryCompare = a.expiryDate!.compareTo(b.expiryDate!);
      if (expiryCompare != 0) return expiryCompare;

      // Same expiry, use FIFO (created_at)
      return a.createdAt.compareTo(b.createdAt);
    });

    return validLots;
  }

  /// Calculate total available stock for a variant in a branch.
  /// Only counts active, non-expired lots.
  Future<int> getTotalAvailableStock({
    required String variantId,
    required String branchId,
  }) async {
    final lots = await getAvailableLots(
      variantId: variantId,
      branchId: branchId,
    );

    int total = 0;
    for (final lot in lots) {
      total += lot.currentQuantity;
    }
    return total;
  }

  /// Consume quantity from lots using FEFO/FIFO order.
  ///
  /// This method:
  /// 1. Gets available lots in FEFO/FIFO order
  /// 2. Iterates through lots, consuming from each until quantity is met
  /// 3. Creates inventory movements for each consumption
  /// 4. Updates lot current_quantity
  ///
  /// Returns a [FifoConsumptionResult] with details of all lots consumed.
  ///
  /// Throws [StockInsufficientException] if not enough stock available.
  Future<FifoConsumptionResult> consumeFifo({
    required String tenantId,
    required String variantId,
    required String branchId,
    required int quantity,
    required String referenceType,
    required String referenceId,
    String? userId,
    String? notes,
  }) async {
    // Validate quantity
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be positive');
    }

    // Get available lots in FEFO/FIFO order
    final lots = await getAvailableLots(
      variantId: variantId,
      branchId: branchId,
    );

    // Calculate total available
    int totalAvailable = 0;
    for (final lot in lots) {
      totalAvailable += lot.currentQuantity;
    }

    // Check if we have enough stock
    if (totalAvailable < quantity) {
      throw StockInsufficientException(
        variantId: variantId,
        branchId: branchId,
        available: totalAvailable.toDouble(),
        required: quantity.toDouble(),
      );
    }

    // Consume from lots
    int remaining = quantity;
    final consumptions = <LotConsumption>[];
    double totalCost = 0;

    for (final lot in lots) {
      if (remaining <= 0) break;

      // Calculate how much to take from this lot
      final toConsume =
          remaining <= lot.currentQuantity ? remaining : lot.currentQuantity;

      final unitCost = lot.unitCost ?? 0;
      final consumptionCost = unitCost * toConsume;

      consumptions.add(LotConsumption(
        lotId: lot.id,
        lotNumber: lot.lotNumber,
        quantityConsumed: toConsume,
        unitCost: unitCost,
        totalCost: consumptionCost,
      ));

      totalCost += consumptionCost;
      remaining -= toConsume;
    }

    return FifoConsumptionResult(
      success: remaining == 0,
      lotsConsumed: consumptions,
      totalQuantityConsumed: quantity - remaining,
      totalCost: totalCost,
      message: remaining == 0
          ? 'Successfully consumed $quantity units from ${consumptions.length} lot(s)'
          : 'Partial consumption: ${quantity - remaining} of $quantity units',
    );
  }

  /// Persist FIFO consumption to database.
  /// Creates inventory movements and updates lot quantities.
  ///
  /// This should be called within a transaction.
  Future<void> persistFifoConsumption({
    required String tenantId,
    required String branchId,
    required String variantId,
    required FifoConsumptionResult consumption,
    required String referenceType,
    required String referenceId,
    String? userId,
    String? notes,
  }) async {
    for (final lotConsumption in consumption.lotsConsumed) {
      final movementId = DateTime.now().millisecondsSinceEpoch.toString() +
          lotConsumption.lotId.substring(0, 8);

      // Create inventory movement (negative quantity = outbound)
      final movement = LocalInventoryMovementsCompanion.insert(
        id: movementId,
        tenantId: tenantId,
        branchId: branchId,
        variantId: variantId,
        lotId: Value(lotConsumption.lotId),
        movementType: MovementType.sale,
        quantity: -lotConsumption.quantityConsumed, // Negative for outbound
        referenceType: Value(referenceType),
        referenceId: Value(referenceId),
        unitCost: Value(lotConsumption.unitCost),
        totalCost: Value(lotConsumption.totalCost),
        createdBy: Value(userId),
        notes: Value(notes),
        synced: const Value(false),
        localId: movementId,
      );

      await _db.into(_db.localInventoryMovements).insert(movement);

      // Update lot current_quantity
      await (_db.update(_db.localInventoryLots)
            ..where((lot) => lot.id.equals(lotConsumption.lotId)))
          .write(LocalInventoryLotsCompanion(
        currentQuantity: Value(
          await _getNewLotQuantity(
            lotConsumption.lotId,
            lotConsumption.quantityConsumed,
          ),
        ),
        updatedAt: Value(DateTime.now()),
      ));

      // Check if lot is depleted
      await _checkAndUpdateLotStatus(lotConsumption.lotId);
    }
  }

  /// Get new quantity for a lot after consumption.
  Future<int> _getNewLotQuantity(String lotId, int consumed) async {
    final lot = await (_db.select(_db.localInventoryLots)
          ..where((l) => l.id.equals(lotId)))
        .getSingle();
    return lot.currentQuantity - consumed;
  }

  /// Check if lot is depleted and update status.
  Future<void> _checkAndUpdateLotStatus(String lotId) async {
    final lot = await (_db.select(_db.localInventoryLots)
          ..where((l) => l.id.equals(lotId)))
        .getSingle();

    if (lot.currentQuantity <= 0) {
      await (_db.update(_db.localInventoryLots)
            ..where((l) => l.id.equals(lotId)))
          .write(const LocalInventoryLotsCompanion(
        status: Value(LotStatus.depleted),
      ));
    }
  }

  /// Get lots that are expiring soon (within days threshold).
  Future<List<LocalInventoryLot>> getExpiringLots({
    required String branchId,
    int daysThreshold = 15,
  }) async {
    final now = DateTime.now();
    final threshold = now.add(Duration(days: daysThreshold));

    final query = _db.select(_db.localInventoryLots)
      ..where((lot) => lot.branchId.equals(branchId))
      ..where((lot) => lot.status.equals('active'))
      ..where((lot) => lot.currentQuantity.isBiggerThanValue(0))
      ..where((lot) => lot.expiryDate.isSmallerOrEqualValue(threshold))
      ..where((lot) => lot.expiryDate.isBiggerThanValue(now))
      ..orderBy([(lot) => OrderingTerm.asc(lot.expiryDate)]);

    return query.get();
  }

  /// Get expired lots that still have stock (for waste reporting).
  Future<List<LocalInventoryLot>> getExpiredLots({
    required String branchId,
  }) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final query = _db.select(_db.localInventoryLots)
      ..where((lot) => lot.branchId.equals(branchId))
      ..where((lot) => lot.status.equals('active'))
      ..where((lot) => lot.currentQuantity.isBiggerThanValue(0))
      ..where((lot) => lot.expiryDate.isSmallerOrEqualValue(today));

    return query.get();
  }
}
