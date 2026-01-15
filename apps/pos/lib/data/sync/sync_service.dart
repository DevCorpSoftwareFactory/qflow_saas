import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pos/data/local/database.dart';

/// Sync service for reconciling local data with the server.
/// Implements offline-first pattern with conflict resolution.
class SyncService {
  final AppDatabase _db;
  
  SyncService(this._db);
  
  /// Process pending sync queue items
  Future<SyncResult> processSyncQueue() async {
    final pendingItems = await (_db.select(_db.syncQueue)
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
      ..limit(50))
      .get();
    
    int successCount = 0;
    int failCount = 0;
    
    for (final item in pendingItems) {
      try {
        await _syncItem(item);
        await (_db.delete(_db.syncQueue)
          ..where((t) => t.id.equals(item.id)))
          .go();
        successCount++;
      } catch (e) {
        failCount++;
        // Update retry count and last error
        await (_db.update(_db.syncQueue)
          ..where((t) => t.id.equals(item.id)))
          .write(SyncQueueCompanion(
            retryCount: Value(item.retryCount + 1),
            lastAttempt: Value(DateTime.now()),
            lastError: Value(e.toString()),
          ));
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
    // TODO: Implement actual API call to server
    // This is a placeholder for the sync logic
    
    switch (item.entityType) {
      case 'sale':
        await _syncSale(item);
        break;
      case 'payment':
        await _syncPayment(item);
        break;
      default:
        throw Exception('Unknown entity type: ${item.entityType}');
    }
  }
  
  Future<void> _syncSale(SyncQueueData item) async {
    final payload = jsonDecode(item.payload);
    
    // TODO: POST to /api/sales
    // On success, update the local sale with synced = true
    // and the server-assigned sale_number
    
    await Future.delayed(const Duration(milliseconds: 100)); // Simulated delay
  }
  
  Future<void> _syncPayment(SyncQueueData item) async {
    final payload = jsonDecode(item.payload);
    
    // TODO: POST to /api/payments
    
    await Future.delayed(const Duration(milliseconds: 100)); // Simulated delay
  }
  
  /// Add item to sync queue
  Future<void> queueForSync({
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
      entityType: entityType,
      entityId: entityId,
      operation: operation,
      payload: jsonEncode(payload),
    ));
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
