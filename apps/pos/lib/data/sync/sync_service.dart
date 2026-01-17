import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../local/database.dart';
import '../api/api_client.dart';

/// Sync service for reconciling local data with the server.
/// Implements offline-first pattern with conflict resolution.
class SyncService {
  final AppDatabase _db;
  final ApiClient _api;

  SyncService(this._db, this._api);

  Future<SyncResult> processSyncQueue() async {
    final pendingItems = await (_db.select(_db.syncQueue)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
          ..limit(50))
        .get();

    int successCount = 0;
    int failCount = 0;

    for (final item in pendingItems) {
      // 1. Validate Integrity
      final validationError = _validateIntegrity(item);
      if (validationError != null) {
        failCount++;
        // Log failure
        await _logAudit(
          entityType: item.entityType,
          entityId: item.entityId,
          operation: item.operation,
          status: 'failed',
          details: 'Validation Error: $validationError',
        );

        // Move to conflicts (Validation Error)
        await _db.into(_db.syncConflicts).insert(
              SyncConflictsCompanion.insert(
                entityType: item.entityType,
                entityId: item.entityId,
                localPayload: item.payload,
                remotePayload: 'Pre-sync Validation Failed: $validationError',
                conflictType: 'validation_error',
              ),
            );

        // Remove from queue (Terminal failure)
        await (_db.delete(_db.syncQueue)..where((t) => t.id.equals(item.id)))
            .go();
        continue;
      }

      try {
        await _syncItem(item);
        await (_db.delete(_db.syncQueue)..where((t) => t.id.equals(item.id)))
            .go();
        successCount++;
      } catch (e) {
        if (e is ApiException && e.statusCode == 409) {
          // 409 Conflict: Handle it
          await _handleConflict(item, e);
          failCount++;
        } else {
          failCount++;
          // Log failure
          await _logAudit(
            entityType: item.entityType,
            entityId: item.entityId,
            operation: item.operation,
            status: 'failed',
            details: e.toString(),
          );

          await (_db.update(_db.syncQueue)..where((t) => t.id.equals(item.id)))
              .write(
            SyncQueueCompanion(
              retryCount: Value(item.retryCount + 1),
              lastAttempt: Value(DateTime.now()),
              lastError: Value(e.toString()),
            ),
          );
        }
      }
    }

    return SyncResult(
      processed: successCount + failCount,
      success: successCount,
      failed: failCount,
      pending: pendingItems.length - successCount,
    );
  }

  String? _validateIntegrity(SyncQueueData item) {
    try {
      final payload = jsonDecode(item.payload);
      if (payload is! Map<String, dynamic>) {
        return 'Payload is not a JSON object';
      }

      switch (item.entityType) {
        case 'sale':
          // Check items
          if (!payload.containsKey('items') ||
              payload['items'] is! List ||
              (payload['items'] as List).isEmpty) {
            return 'Sale must have at least one item';
          }
          // Check total
          if (!payload.containsKey('total') ||
              (payload['total'] is num && (payload['total'] as num) < 0)) {
            return 'Sale total cannot be negative';
          }
          break;
      }
      return null; // Valid
    } catch (e) {
      return 'Invalid JSON: $e';
    }
  }

  Future<void> _logAudit({
    required String entityType,
    required String entityId,
    required String operation,
    required String status,
    String? details,
  }) async {
    await _db.into(_db.syncAudit).insert(
          SyncAuditCompanion.insert(
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            status: status,
            details: Value(details),
            timestamp: Value(DateTime.now()),
          ),
        );
  }

  Future<void> _syncItem(SyncQueueData item) async {
    switch (item.entityType) {
      case 'sale':
        await _syncSale(item);
        break;
      case 'payment':
        break;
      case 'cash_session':
        await _syncCashSession(item);
        break;
      case 'cash_movement':
        await _syncCashMovement(item);
        break;
      default:
        throw Exception('Unknown entity type: ${item.entityType}');
    }
    // Log success
    await _logAudit(
      entityType: item.entityType,
      entityId: item.entityId,
      operation: item.operation,
      status: 'success',
    );
  }

  Future<void> _syncSale(SyncQueueData item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final response = await _api.post('/sales', payload);

    await _db.transaction(() async {
      await (_db.update(_db.localSales)
            ..where((t) => t.id.equals(item.entityId)))
          .write(
        LocalSalesCompanion(
          synced: const Value(true),
          saleNumber: Value(response['saleNumber']),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<void> _syncCashSession(SyncQueueData item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;

    if (item.operation == 'create') {
      await _api.post('/cash-sessions', payload);
    } else if (item.operation == 'update') {
      await _api.put('/cash-sessions/${item.entityId}', payload);
    }

    await (_db.update(_db.localCashSessions)
          ..where((t) => t.id.equals(item.entityId)))
        .write(
      LocalCashSessionsCompanion(
        synced: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _syncCashMovement(SyncQueueData item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;

    await _api.post('/cash-movements', payload);

    await (_db.update(_db.localCashMovements)
          ..where((t) => t.id.equals(item.entityId)))
        .write(
      LocalCashMovementsCompanion(
        synced: const Value(true),
        syncedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> queueForSync({
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    await _db.into(_db.syncQueue).insert(
          SyncQueueCompanion.insert(
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: jsonEncode(payload),
          ),
        );
  }

  Future<int> getPendingSyncCount() async {
    final query = _db.selectOnly(_db.syncQueue)..addColumns([countAll()]);
    final result = await query.getSingle();
    return result.read(countAll()) ?? 0;
  }

  Future<void> _handleConflict(SyncQueueData item, ApiException error) async {
    bool autoResolved = false;
    try {
      final localJson = jsonDecode(item.payload) as Map<String, dynamic>;
      final remoteJson = jsonDecode(error.message) as Map<String, dynamic>;

      if (localJson.containsKey('updatedAt') &&
          remoteJson.containsKey('updatedAt')) {
        final localDate = DateTime.parse(localJson['updatedAt']);
        final remoteDate = DateTime.parse(remoteJson['updatedAt']);

        if (localDate.isAfter(remoteDate)) {
          // Client Wins
          await _db.update(_db.syncQueue).replace(item.copyWith(
                retryCount: 0,
                priority: 10,
                lastAttempt: Value(DateTime.now()),
                lastError: Value('Auto-resolved: Client Newer'),
              ));
          autoResolved = true;
        } else {
          // Server Wins
          await (_db.delete(_db.syncQueue)..where((t) => t.id.equals(item.id)))
              .go();
          autoResolved = true;
        }
      }
    } catch (e) {
      debugPrint('LWW Check failed: $e');
    }

    if (!autoResolved) {
      // Log conflict
      await _logAudit(
        entityType: item.entityType,
        entityId: item.entityId,
        operation: item.operation,
        status: 'conflict',
        details: error.message,
      );

      await _db.into(_db.syncConflicts).insert(
            SyncConflictsCompanion.insert(
              entityType: item.entityType,
              entityId: item.entityId,
              localPayload: item.payload,
              remotePayload: error.message,
              conflictType: 'server_rejection',
            ),
          );

      await (_db.delete(_db.syncQueue)..where((t) => t.id.equals(item.id)))
          .go();
    } else {
      // Log auto-resolution
      await _logAudit(
        entityType: item.entityType,
        entityId: item.entityId,
        operation: item.operation,
        status: 'resolved',
        details: 'Auto-resolved LWW',
      );
    }
  }

  Future<List<SyncConflict>> getConflicts() {
    return _db.select(_db.syncConflicts).get();
  }

  Future<void> resolveConflictKeepLocal(int conflictId) async {
    await _db.transaction(() async {
      final conflict = await (_db.select(_db.syncConflicts)
            ..where((t) => t.id.equals(conflictId)))
          .getSingle();

      // Log resolution
      await _logAudit(
        entityType: conflict.entityType,
        entityId: conflict.entityId,
        operation: 'update',
        status: 'resolved',
        details: 'Manual: Client Wins',
      );

      await _db.into(_db.syncQueue).insert(
            SyncQueueCompanion.insert(
              entityType: conflict.entityType,
              entityId: conflict.entityId,
              operation: 'update',
              payload: conflict.localPayload,
              retryCount: const Value(0),
              priority: const Value(10),
            ),
          );

      await (_db.delete(_db.syncConflicts)
            ..where((t) => t.id.equals(conflictId)))
          .go();
    });
  }

  Future<void> resolveConflictKeepRemote(int conflictId) async {
    await _db.transaction(() async {
      final conflict = await (_db.select(_db.syncConflicts)
            ..where((t) => t.id.equals(conflictId)))
          .getSingle();

      // Log resolution
      await _logAudit(
        entityType: conflict.entityType,
        entityId: conflict.entityId,
        operation: 'update',
        status: 'resolved',
        details: 'Manual: Server Wins',
      );

      await (_db.delete(_db.syncConflicts)
            ..where((t) => t.id.equals(conflictId)))
          .go();
    });
  }
}

class SyncResult {
  final int processed;
  final int success;
  final int failed;
  final int pending;

  SyncResult({
    required this.processed,
    required this.success,
    required this.failed,
    required this.pending,
  });

  bool get hasFailures => failed > 0;
  bool get hasPending => pending > 0;
}
