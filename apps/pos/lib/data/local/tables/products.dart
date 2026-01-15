// =============================================================================
// Products Table - Drift Definition
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 1274-1337
// =============================================================================

import 'package:drift/drift.dart';

/// Entidad LÓGICA del producto. NO tiene precio NI stock.
/// Solo define qué es el producto.
class LocalProducts extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();

  // Identificación
  TextColumn get code => text()(); // Código interno del producto
  TextColumn get barcodeType => text().nullable()(); // EAN13, CODE128, QR

  // Datos básicos
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get shortName => text().nullable()();

  // Clasificación
  TextColumn get categoryId => text().nullable()();
  TextColumn get brandId => text().nullable()();
  TextColumn get unitId => text().nullable()();

  // Características de inventario
  BoolColumn get hasExpiry => boolean().withDefault(const Constant(false))();
  BoolColumn get hasBatchControl =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get trackInventory =>
      boolean().withDefault(const Constant(true))();

  // Umbrales
  IntColumn get minStock => integer().withDefault(const Constant(0))();
  IntColumn get maxStock => integer().nullable()();
  IntColumn get reorderPoint => integer().nullable()();

  // Atributos
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isSalable => boolean().withDefault(const Constant(true))();
  BoolColumn get isPurchasable => boolean().withDefault(const Constant(true))();
  BoolColumn get isReturnable => boolean().withDefault(const Constant(true))();

  // Atributos para alimentación
  BoolColumn get requiresCooling =>
      boolean().withDefault(const Constant(false))();
  RealColumn get storageTemperatureMin => real().nullable()();
  RealColumn get storageTemperatureMax => real().nullable()();

  // Información nutricional (JSON)
  TextColumn get nutritionalInfo => text().nullable()();

  // Sync
  DateTimeColumn get lastSync => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
