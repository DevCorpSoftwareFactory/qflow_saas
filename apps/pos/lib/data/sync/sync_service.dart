import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/data/api/api_client.dart';

/// Sync service for reconciling local data with the server.
/// Implements offline-first pattern with conflict resolution.
class SyncService {
  final AppDatabase _db;

  final ApiClient _api;

  SyncService(this._db, this._api);

  /// Process pending sync queue items
  Future<SyncResult> processSyncQueue() async {
    final pendingItems =
        await (_db.select(_db.syncQueue)
              ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
              ..limit(50))
            .get();

    int successCount = 0;
    int failCount = 0;

    for (final item in pendingItems) {
      try {
        await _syncItem(item);
        await (_db.delete(
          _db.syncQueue,
        )..where((t) => t.id.equals(item.id))).go();
        successCount++;
      } catch (e) {
        failCount++;
        // Update retry count and last error
        await (_db.update(
          _db.syncQueue,
        )..where((t) => t.id.equals(item.id))).write(
          SyncQueueCompanion(
            retryCount: Value(item.retryCount + 1),
            lastAttempt: Value(DateTime.now()),
            lastError: Value(e.toString()),
          ),
        );
      }
    }

    return SyncResult(
      processed: successCount + failCount,
      success: successCount,
      failed: failCount,
      pending: pendingItems.length - successCount,
    );
  }

  /// Sync a single item to the server
  Future<void> _syncItem(SyncQueueData item) async {
    switch (item.entityType) {
      case 'sale':
        await _syncSale(item);
        break;
      case 'payment':
        // Payments are currently included in sales sync, but can be synced separately if needed
        // await _syncPayment(item);
        break;
      default:
        throw Exception('Unknown entity type: ${item.entityType}');
    }
  }

  Future<void> _syncSale(SyncQueueData item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;

    // POST to /sales
    final response = await _api.post('/sales', payload);

    // Update local sale with server data
    await _db.transaction(() async {
      await (_db.update(
        _db.localSales,
      )..where((t) => t.id.equals(item.entityId))).write(
        LocalSalesCompanion(
          synced: const Value(true),
          saleNumber: Value(response['saleNumber']),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Add item to sync queue
  Future<void> queueForSync({
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    await _db
        .into(_db.syncQueue)
        .insert(
          SyncQueueCompanion.insert(
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: jsonEncode(payload),
          ),
        );
  }

  /// Get pending sync count
  Future<int> getPendingSyncCount() async {
    final query = _db.selectOnly(_db.syncQueue)..addColumns([countAll()]);
    final result = await query.getSingle();
    return result.read(countAll()) ?? 0;
  }
}

/// Result of a sync operation
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
