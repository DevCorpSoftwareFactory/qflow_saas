// =============================================================================
// Inventory Tables - Drift Definition
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 1691-1814
// =============================================================================

import 'package:drift/drift.dart';
import 'enums.dart';
import 'product_variants.dart';

/// Lotes de inventario - UNIDAD BÁSICA DE TRAZABILIDAD para alimentos.
/// PROHIBIDO hacer UPDATE de stock directo.
class LocalInventoryLots extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  // Identificación del lote
  TextColumn get lotNumber => text()();
  
  // Referencias
  TextColumn get variantId => text().references(LocalProductVariants, #id)();
  TextColumn get purchaseInvoiceId => text().nullable()();
  TextColumn get branchId => text()();
  
  // Cantidades
  IntColumn get initialQuantity => integer()();
  IntColumn get currentQuantity => integer()();
  
  // Precios
  RealColumn get purchasePrice => real()();  // PRECIO TOTAL de compra
  RealColumn get unitCost => real().nullable()();  // Costo unitario
  
  // Fechas críticas
  DateTimeColumn get productionDate => dateTime().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();  // CRÍTICO para alimentos
  
  // Estado: active, depleted, expired, returned, waste
  TextColumn get status => textEnum<LotStatus>().withDefault(const Constant('active'))();
  
  TextColumn get notes => text().nullable()();
  
  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Kardex de inventario - REGISTRO INMUTABLE de todos los movimientos.
/// Para corregir, hacer movimiento de ajuste.
class LocalInventoryMovements extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  // Referencias
  TextColumn get lotId => text().nullable()();  // Puede ser null para POS offline
  TextColumn get branchId => text()();
  TextColumn get variantId => text().references(LocalProductVariants, #id)();
  
  // Tipo de movimiento
  TextColumn get movementType => textEnum<MovementType>()();
  
  // Cantidad (positiva = entrada, negativa = salida)
  IntColumn get quantity => integer()();
  
  // Referencia a transacción origen
  TextColumn get referenceType => text().nullable()();  // sale, purchase, transfer
  TextColumn get referenceId => text().nullable()();
  
  TextColumn get notes => text().nullable()();
  
  // Costos
  RealColumn get unitCost => real().nullable()();
  RealColumn get totalCost => real().nullable()();
  
  // Usuario
  TextColumn get createdBy => text().nullable()();
  
  // Timestamp
  DateTimeColumn get movementDate => dateTime().withDefault(currentDateAndTime)();
  
  // Sincronización offline
  TextColumn get localId => text()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
