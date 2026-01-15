// =============================================================================
// Product Variants Table - Drift Definition
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 1345-1402
// =============================================================================

import 'package:drift/drift.dart';
import 'products.dart';

/// Entidad FÍSICA del producto - SKU real en inventario.
/// Ej: "Queso Fresco 500g" vs "Queso Fresco 1kg"
class LocalProductVariants extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get productId => text().references(LocalProducts, #id)();
  
  // Identificación
  TextColumn get sku => text()();  // Código de inventario único
  TextColumn get barcode => text().nullable()();  // Código de barras para escáner
  
  // Atributos de variante (JSON: {presentation: "500g", flavor: "natural"})
  TextColumn get attributes => text().withDefault(const Constant('{}'))();
  
  // Precio caché (real price está en price_list_items)
  RealColumn get price => real().withDefault(const Constant(0.0))();
  
  // Peso/Volumen para logística
  RealColumn get weightKg => real().nullable()();
  RealColumn get volumeLiters => real().nullable()();
  
  // Configuración
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Sync
  DateTimeColumn get lastSync => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
