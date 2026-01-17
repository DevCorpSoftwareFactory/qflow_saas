import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pos/data/api/api_client.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/data/sync/sync_service.dart';

void main() {
  late AppDatabase db;
  late SyncService service;
  late Directory tempDir;

  setUp(() {
    // Initialize Hive with a temporary directory
    tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);

    db = AppDatabase.forTesting(NativeDatabase.memory());

    // Initialize service with default mock (can be overridden in tests)
    final mockClient = MockClient((request) async => http.Response('{}', 200));
    final api = ApiClient(baseUrl: 'http://test.com', client: mockClient);
    service = SyncService(db, api);
  });

  tearDown(() async {
    await db.close();
    await Hive.deleteFromDisk();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('processSyncQueue moves item to conflicts table on 409 error', () async {
    // 1. Arrange: Mock HTTP 409
    final mockClient = MockClient((request) async {
      if (request.url.path.contains('/sales')) {
        return http.Response('{"server_state": "modified"}', 409);
      }
      return http.Response('{}', 200);
    });

    final api = ApiClient(baseUrl: 'http://test.com', client: mockClient);
    service = SyncService(db, api);

    // Add item to queue
    await service.queueForSync(
      entityType: 'sale',
      entityId: 'sale-1',
      operation: 'create',
      payload: {
        'total': 100,
        'items': [
          {'productId': 'p1', 'quantity': 1}
        ]
      },
    );

    // 2. Act
    final result = await service.processSyncQueue();

    // 3. Assert
    // Queue should be empty (moved to conflicts)
    final pendingCount = await service.getPendingSyncCount();
    expect(pendingCount, 0);

    // Conflict table should have 1 entry
    final conflicts = await db.select(db.syncConflicts).get();
    expect(conflicts.length, 1);
    expect(conflicts.first.entityId, 'sale-1');
    expect(conflicts.first.conflictType, 'server_rejection');
    expect(conflicts.first.remotePayload, contains('server_state'));

    // Result should show 1 fail
    expect(result.failed, 1);
  });

  test('resolveConflictKeepRemote deletes conflict', () async {
    // 1. Arrange: Insert a conflict
    await db.into(db.syncConflicts).insert(
          SyncConflictsCompanion.insert(
            entityType: 'sale',
            entityId: 'sale-del',
            localPayload: '{}',
            remotePayload: '{}',
            conflictType: 'manual',
          ),
        );

    final conflict = await db.select(db.syncConflicts).getSingle();

    // 2. Act
    await service.resolveConflictKeepRemote(conflict.id);

    // 3. Assert
    final count = await db.select(db.syncConflicts).get().then((l) => l.length);
    expect(count, 0);
  });

  test('resolveConflictKeepLocal moves conflict back to queue', () async {
    // 1. Arrange: Insert a conflict
    await db.into(db.syncConflicts).insert(
          SyncConflictsCompanion.insert(
            entityType: 'sale',
            entityId: 'sale-retry',
            localPayload: '{"amount": 500}',
            remotePayload: '{}',
            conflictType: 'manual',
          ),
        );

    final conflict = await db.select(db.syncConflicts).getSingle();

    // 2. Act
    await service.resolveConflictKeepLocal(conflict.id);

    // Verify conflict resolved
    final conflicts = await db.select(db.syncConflicts).get();
    expect(conflicts, isEmpty);

    // Verify item re-queued with high priority
    final queue = await db.select(db.syncQueue).get();
    expect(queue, hasLength(1));
    expect(queue.first.priority, 10);
    expect(queue.first.retryCount, 0);

    // Verify audit logs
    final audits = await db.select(db.syncAudit).get();
    // Should have:
    // 1. 'conflict' from detection
    // 2. 'resolved' from manual resolution
    // Note: detection calls _handleConflict which logs 'conflict'
    // Manual resolution calls logs 'resolved'
    expect(audits.length,
        greaterThanOrEqualTo(1)); // At least one audit for resolution
    expect(audits.any((a) => a.status == 'resolved'), isTrue);
  });

  test('Sync success creates success audit log', () async {
    // Re-initialize service with a client that returns success
    final mockClient = MockClient(
        (request) async => http.Response('{"saleNumber": "101"}', 200));
    final api = ApiClient(baseUrl: 'http://test.com', client: mockClient);
    service = SyncService(db, api);

    await service.queueForSync(
      entityType: 'sale',
      entityId: 'sale-123',
      operation: 'create',
      payload: {
        'saleNumber': '101',
        'total': 100,
        'items': [
          {'productId': 'p1', 'quantity': 1}
        ]
      },
    );

    await service.processSyncQueue();

    final audits = await db.select(db.syncAudit).get();
    expect(audits.isNotEmpty, isTrue);
    expect(audits.first.status, equals('success'));
    expect(audits.first.entityId, equals('sale-123'));
  });

  test('Pre-sync validation rejects invalid items', () async {
    // Queue invalid sale (no items)
    await service.queueForSync(
      entityType: 'sale',
      entityId: 'sale-invalid',
      operation: 'create',
      payload: {'total': 100, 'items': []}, // Empty items list
    );

    await service.processSyncQueue();

    // Verify removed from queue
    final queue = await db.select(db.syncQueue).get();
    expect(queue, isEmpty);

    // Verify in conflicts with validation_error
    final conflicts = await db.select(db.syncConflicts).get();
    expect(conflicts, hasLength(1));
    expect(conflicts.first.conflictType, 'validation_error');
    expect(conflicts.first.remotePayload,
        contains('Sale must have at least one item'));

    // Verify audit log failure
    final audits = await db.select(db.syncAudit).get();
    expect(
        audits.any((a) =>
            a.status == 'failed' && a.details!.contains('Validation Error')),
        isTrue);
  });
}
