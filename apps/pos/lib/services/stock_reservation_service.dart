import 'package:drift/drift.dart';

import '../data/local/database.dart';

/// Service for calculating reserved stock from pending orders.
///
/// Stock is considered "reserved" when it appears in order_items
/// for orders with status: requested, confirmed, preparing, ready
/// (i.e., orders that have not been delivered or cancelled)
///
/// This is used by StockService to calculate available stock accurately.
class StockReservationService {
  final AppDatabase _db;

  StockReservationService({required AppDatabase database}) : _db = database;

  /// Get total reserved quantity for a variant in a branch.
  /// Reserved = sum of (quantity - quantity_delivered) for pending orders.
  Future<int> getReservedQuantity({
    required String variantId,
    required String branchId,
  }) async {
    // Build query to get pending order items
    final query = _db.customSelect(
      '''
      SELECT COALESCE(SUM(oi.quantity - oi.quantity_delivered), 0) as reserved
      FROM local_order_items oi
      INNER JOIN local_orders o ON o.id = oi.order_id
      WHERE oi.variant_id = ?
        AND o.branch_id = ?
        AND o.status IN ('requested', 'confirmed', 'preparing', 'ready')
        AND o.deleted_at IS NULL
      ''',
      variables: [
        Variable.withString(variantId),
        Variable.withString(branchId),
      ],
      readsFrom: {_db.localOrders, _db.localOrderItems},
    );

    final result = await query.getSingle();
    return (result.data['reserved'] as num?)?.toInt() ?? 0;
  }

  /// Get reserved quantities for multiple variants at once (batch query).
  Future<Map<String, int>> getReservedQuantities({
    required List<String> variantIds,
    required String branchId,
  }) async {
    if (variantIds.isEmpty) return {};

    // Build placeholders for IN clause
    final placeholders = variantIds.map((_) => '?').join(', ');

    final query = _db.customSelect(
      '''
      SELECT oi.variant_id, COALESCE(SUM(oi.quantity - oi.quantity_delivered), 0) as reserved
      FROM local_order_items oi
      INNER JOIN local_orders o ON o.id = oi.order_id
      WHERE oi.variant_id IN ($placeholders)
        AND o.branch_id = ?
        AND o.status IN ('requested', 'confirmed', 'preparing', 'ready')
        AND o.deleted_at IS NULL
      GROUP BY oi.variant_id
      ''',
      variables: [
        ...variantIds.map((id) => Variable.withString(id)),
        Variable.withString(branchId),
      ],
      readsFrom: {_db.localOrders, _db.localOrderItems},
    );

    final results = await query.get();

    return {
      for (final row in results)
        row.data['variant_id'] as String:
            (row.data['reserved'] as num?)?.toInt() ?? 0,
    };
  }

  /// Get all pending orders for a branch.
  Future<List<PendingOrderInfo>> getPendingOrders({
    required String branchId,
  }) async {
    final orders = await (_db.select(_db.localOrders)
          ..where((o) => o.branchId.equals(branchId))
          ..where((o) => o.status.isIn([
                OrderStatus.requested.name,
                OrderStatus.confirmed.name,
                OrderStatus.preparing.name,
                OrderStatus.ready.name,
              ]))
          ..where((o) => o.deletedAt.isNull())
          ..orderBy([(o) => OrderingTerm.asc(o.requestedDeliveryDate)]))
        .get();

    final result = <PendingOrderInfo>[];

    for (final order in orders) {
      final items = await (_db.select(_db.localOrderItems)
            ..where((i) => i.orderId.equals(order.id)))
          .get();

      final pendingItems = items
          .where((i) => i.quantity > i.quantityDelivered)
          .map((i) => PendingOrderItem(
                variantId: i.variantId,
                quantityOrdered: i.quantity,
                quantityDelivered: i.quantityDelivered,
                quantityPending: i.quantity - i.quantityDelivered,
              ))
          .toList();

      result.add(PendingOrderInfo(
        orderId: order.id,
        orderNumber: order.orderNumber,
        customerId: order.customerId,
        status: order.status,
        requestedDeliveryDate: order.requestedDeliveryDate,
        items: pendingItems,
      ));
    }

    return result;
  }

  /// Check if a specific quantity can be fulfilled considering reservations.
  /// Returns true if available stock minus reservations >= requested quantity.
  Future<bool> canFulfill({
    required String variantId,
    required String branchId,
    required int availableStock,
    required int requestedQuantity,
  }) async {
    final reserved = await getReservedQuantity(
      variantId: variantId,
      branchId: branchId,
    );

    return (availableStock - reserved) >= requestedQuantity;
  }
}

/// Information about a pending order.
class PendingOrderInfo {
  final String orderId;
  final String orderNumber;
  final String customerId;
  final OrderStatus status;
  final DateTime? requestedDeliveryDate;
  final List<PendingOrderItem> items;

  const PendingOrderInfo({
    required this.orderId,
    required this.orderNumber,
    required this.customerId,
    required this.status,
    this.requestedDeliveryDate,
    required this.items,
  });

  int get totalPendingQuantity =>
      items.fold(0, (sum, item) => sum + item.quantityPending);
}

/// Information about a pending order item.
class PendingOrderItem {
  final String variantId;
  final int quantityOrdered;
  final int quantityDelivered;
  final int quantityPending;

  const PendingOrderItem({
    required this.variantId,
    required this.quantityOrdered,
    required this.quantityDelivered,
    required this.quantityPending,
  });
}
