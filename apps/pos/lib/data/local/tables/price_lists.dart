// =============================================================================
// Price Lists Tables - Drift Definition
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 1409-1482
// =============================================================================

import 'package:drift/drift.dart';
import 'product_variants.dart';

/// Listas de precios según tipo de cliente.
/// Evita tener precio fijo en products.
class LocalPriceLists extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  TextColumn get name => text()();  // "Minorista", "Mayorista", "VIP"
  TextColumn get description => text().nullable()();
  
  // Tipo de cliente: retail, wholesale, vip, null=todas
  TextColumn get customerType => text().nullable()();
  
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Validez temporal
  DateTimeColumn get validFrom => dateTime().nullable()();
  DateTimeColumn get validTo => dateTime().nullable()();
  
  // Sync
  DateTimeColumn get lastSync => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Precio de cada variante en cada lista de precios.
/// Permite descuentos por volumen.
class LocalPriceListItems extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get priceListId => text().references(LocalPriceLists, #id)();
  TextColumn get variantId => text().references(LocalProductVariants, #id)();
  
  RealColumn get price => real()();
  RealColumn get costPrice => real().nullable()();  // Para márgenes
  
  // Descuento por volumen
  IntColumn get minQuantity => integer().withDefault(const Constant(1))();
  IntColumn get maxQuantity => integer().nullable()();
  RealColumn get volumeDiscountPercent => real().withDefault(const Constant(0))();
  
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Sync
  DateTimeColumn get lastSync => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
