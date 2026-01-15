// =============================================================================
// Catalog Tables - Drift Definition
// =============================================================================
// Categories, Brands, Units of Measure
// Based on: qflow_pro_ddl_complete.sql
// =============================================================================

import 'package:drift/drift.dart';

/// Categorías jerárquicas de productos.
/// Ejemplo: Lácteos > Quesos > Queso Fresco
class LocalProductCategories extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get code => text().nullable()();
  
  // Jerarquía
  TextColumn get parentId => text().nullable()();  // Autoreferencia
  IntColumn get level => integer().withDefault(const Constant(0))();
  
  // Visualización
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Sync
  DateTimeColumn get lastSync => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Marcas de productos. Ejemplos: Alpina, Colanta, Zenú
class LocalBrands extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get website => text().nullable()();
  
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Sync
  DateTimeColumn get lastSync => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Unidades de medida: kg, g, lb, oz, L, mL, unidad, etc.
class LocalUnitsOfMeasure extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  TextColumn get name => text()();  // kilogramo, litro, unidad
  TextColumn get abbreviation => text()();  // kg, L, un
  TextColumn get unitType => text()();  // weight, volume, quantity, length
  
  // Conversión a unidad base
  RealColumn get conversionFactor => real().nullable()();
  TextColumn get baseUnitId => text().nullable()();
  
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Sync
  DateTimeColumn get lastSync => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
