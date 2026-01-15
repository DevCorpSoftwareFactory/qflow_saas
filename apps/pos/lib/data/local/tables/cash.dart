// =============================================================================
// Cash Management Tables - Drift Definition
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 2249-2364
// =============================================================================

import 'package:drift/drift.dart';
import 'enums.dart';

/// Cajas físicas configuradas por sucursal
class LocalCashRegisters extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  
  TextColumn get code => text()();
  TextColumn get name => text()();
  
  // Configuración de impresora (JSON)
  TextColumn get printerConfig => text().nullable()();
  
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Sesiones de caja. CIERRE CIEGO: system_amount (sistema) vs declared_amount (cajero)
class LocalCashSessions extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  TextColumn get cashRegisterId => text().references(LocalCashRegisters, #id)();
  TextColumn get userId => text()();
  
  // Fechas
  DateTimeColumn get openingDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get closingDate => dateTime().nullable()();
  
  // Fondo inicial
  RealColumn get initialAmount => real().withDefault(const Constant(0))();
  
  // 💰 SEPARACIÓN CIEGA (PROPÓSITO DEL MÓDULO)
  RealColumn get systemAmount => real().withDefault(const Constant(0))();  // Lo que dice el sistema
  RealColumn get declaredAmount => real().nullable()();  // Lo que cuenta el cajero
  // difference = declared - system (calculado en app)
  
  // Justificación de diferencia
  TextColumn get differenceJustification => text().nullable()();
  
  // Estado
  TextColumn get status => textEnum<SessionStatus>().withDefault(const Constant('open'))();
  TextColumn get approvedBy => text().nullable()();
  DateTimeColumn get approvedAt => dateTime().nullable()();
  TextColumn get approvalNotes => text().nullable()();
  
  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Ingresos y egresos de caja
class LocalCashMovements extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  TextColumn get cashSessionId => text().nullable().references(LocalCashSessions, #id)();
  TextColumn get branchId => text().nullable()();
  
  // Tipo: income, expense, withdrawal, transfer_in, transfer_out
  TextColumn get movementType => textEnum<CashMovementType>()();
  TextColumn get category => textEnum<CashMovementCategory>().nullable()();
  
  RealColumn get amount => real()();
  TextColumn get concept => text()();
  TextColumn get reference => text().nullable()();
  
  // Evidencia
  TextColumn get evidenceUrl => text().nullable()();
  
  // Usuario
  TextColumn get createdBy => text().nullable()();
  
  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
