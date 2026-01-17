// =============================================================================
// Orders Tables - Drift Definition (B2B Orders)
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 2165-2244
// Orders for wholesale customers, including stock reservations
// =============================================================================

import 'package:drift/drift.dart';
import 'customers.dart';
import 'enums.dart';

/// Pedidos B2B (mayoristas)
/// Stock se RESERVA cuando status está en: requested, confirmed, preparing, ready
/// Stock se CONSUME cuando status cambia a: delivered
class LocalOrders extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();

  // Número de pedido único por tenant
  TextColumn get orderNumber => text()();

  // Cliente
  TextColumn get customerId => text().references(LocalCustomers, #id)();

  // Fechas
  DateTimeColumn get orderDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get requestedDeliveryDate => dateTime().nullable()();
  DateTimeColumn get actualDeliveryDate => dateTime().nullable()();

  // Estado
  TextColumn get status =>
      textEnum<OrderStatus>().withDefault(const Constant('requested'))();

  // Dirección de entrega
  TextColumn get deliveryAddress => text().nullable()();
  TextColumn get deliveryNotes => text().nullable()();
  TextColumn get deliveryZone => text().nullable()();

  // Totales
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get shippingCost => real().withDefault(const Constant(0))();
  RealColumn get taxAmount => real().withDefault(const Constant(0))();
  RealColumn get totalAmount => real().withDefault(const Constant(0))();

  // Pago
  TextColumn get paymentStatus =>
      textEnum<PaymentStatus>().withDefault(const Constant('pending'))();
  RealColumn get amountPaid => real().withDefault(const Constant(0))();

  // Usuario responsable
  TextColumn get salesRepId => text().nullable()();

  // Notas
  TextColumn get notes => text().nullable()();

  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();

  // Auditoría
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Items de pedido - stock reservado
class LocalOrderItems extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();

  // Relación con pedido
  TextColumn get orderId => text().references(LocalOrders, #id)();
  TextColumn get variantId => text()();

  // Cantidades
  IntColumn get quantity => integer()(); // Cantidad solicitada
  IntColumn get quantityDelivered =>
      integer().withDefault(const Constant(0))(); // Cantidad entregada

  // Precio al momento del pedido (histórico)
  RealColumn get unitPrice => real()();
  RealColumn get subtotal => real()();

  // Lote reservado (si aplica FIFO pre-asignación)
  TextColumn get reservedLotId => text().nullable()();

  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  TextColumn get localId => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
