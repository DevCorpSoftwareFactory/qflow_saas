// =============================================================================
// Sync Queue Table - Drift Definition
// =============================================================================
// Queue for pending offline operations to sync with server
// =============================================================================

import 'package:drift/drift.dart';

/// Cola de sincronización para operaciones offline pendientes
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get entityType => text()(); // sale, payment, cash_movement, etc.
  TextColumn get entityId => text()();
  TextColumn get operation => text()(); // create, update, delete
  TextColumn get payload => text()(); // JSON payload

  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  IntColumn get priority =>
      integer().withDefault(const Constant(0))(); // Higher = more urgent

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastAttempt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
}

/// Tabla para registro de conflictos de sincronización
class SyncConflicts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get entityType => text()();
  TextColumn get entityId => text()();

  TextColumn get localPayload => text()(); // Estado local en JSON
  TextColumn get remotePayload =>
      text()(); // Estado remoto en JSON (lo que llegó del servidor)

  // Tipo de conflicto: 'remote_newer', 'deleted_remote', 'concurrent_edit'
  TextColumn get conflictType => text()();

  DateTimeColumn get detectedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get resolutionStrategy =>
      text().nullable()(); // 'server_wins', 'client_wins', 'manual'

  BoolColumn get resolved => boolean().withDefault(const Constant(false))();
}
