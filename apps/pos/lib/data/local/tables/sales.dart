// =============================================================================
// Sales Tables - Drift Definition
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 2038-2165
// =============================================================================

import 'package:drift/drift.dart';
import 'enums.dart';
import 'customers.dart';
import 'product_variants.dart';

/// Encabezado de venta POS
class LocalSales extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();

  // Identificación
  TextColumn get saleNumber => text().nullable()();
  TextColumn get customerId =>
      text().nullable().references(LocalCustomers, #id)();

  // Fechas
  DateTimeColumn get saleDate => dateTime().withDefault(currentDateAndTime)();

  // Tipo y Estado
  TextColumn get saleType =>
      textEnum<SaleType>().withDefault(const Constant('retail'))();
  TextColumn get status =>
      textEnum<SaleStatus>().withDefault(const Constant('completed'))();

  // Totales
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get discountPercent => real().withDefault(const Constant(0))();
  RealColumn get discountAmount => real().withDefault(const Constant(0))();
  RealColumn get taxAmount => real().withDefault(const Constant(0))();
  RealColumn get totalAmount => real().withDefault(const Constant(0))();

  // Usuario
  TextColumn get cashierId => text()();

  // Notas
  TextColumn get notes => text().nullable()();
  TextColumn get internalNotes => text().nullable()();

  // Offline sync
  TextColumn get localId => text()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Detalle de venta. unit_price es INMUTABLE (precio histórico al momento de venta)
class LocalSaleItems extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text().nullable()();

  TextColumn get saleId => text().references(LocalSales, #id)();
  TextColumn get lotId => text().nullable()(); // Lote consumido
  TextColumn get variantId => text().references(LocalProductVariants, #id)();

  // Cantidad
  IntColumn get quantity => integer()();

  // Precios (HISTÓRICOS - no se actualizan después)
  RealColumn get unitPrice => real()(); // Precio al momento de la venta
  RealColumn get costPrice => real().nullable()(); // Costo del lote

  // Descuentos
  RealColumn get discountPercent => real().withDefault(const Constant(0))();
  RealColumn get discountAmount => real().withDefault(const Constant(0))();

  // Cálculos
  RealColumn get subtotal => real()();

  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Métodos de pago en cada venta. Una venta puede tener múltiples pagos.
class LocalSalePayments extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text().nullable()();

  TextColumn get saleId => text().references(LocalSales, #id)();
  TextColumn get paymentMethod => textEnum<PaymentMethod>()();
  RealColumn get amount => real()();

  // Referencia
  TextColumn get reference => text().nullable()(); // Número de transacción
  TextColumn get cardLastFour => text().nullable()();

  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
