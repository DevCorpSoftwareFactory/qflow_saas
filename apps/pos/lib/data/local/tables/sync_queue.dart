// =============================================================================
// Sync Queue Table - Drift Definition
// =============================================================================
// Queue for pending offline operations to sync with server
// =============================================================================

import 'package:drift/drift.dart';

/// Cola de sincronización para operaciones offline pendientes
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  TextColumn get entityType => text()();  // sale, payment, cash_movement, etc.
  TextColumn get entityId => text()();
  TextColumn get operation => text()();  // create, update, delete
  TextColumn get payload => text()();  // JSON payload
  
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  IntColumn get priority => integer().withDefault(const Constant(0))();  // Higher = more urgent
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastAttempt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
}
