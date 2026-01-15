import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:pos/data/local/database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    // Use in-memory database for testing
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Drift Database Connection Tests', () {
    test('Database initializes successfully', () {
      expect(database, isNotNull);
      expect(database.schemaVersion, equals(1));
    });

    test('Can insert and query sales', () async {
      // Insert a test sale
      await database.into(database.localSales).insert(LocalSalesCompanion.insert(
        id: 'test-sale-001',
        tenantId: 'tenant-001',
        branchId: 'branch-001',
        cashierId: 'cashier-001',
        localId: 'local-001',
      ));

      // Query sales
      final sales = await database.select(database.localSales).get();
      expect(sales.length, equals(1));
      expect(sales.first.id, equals('test-sale-001'));
      expect(sales.first.synced, equals(false));
    });

    test('Can insert and query products', () async {
      // Insert a test product
      await database.into(database.localProducts).insert(LocalProductsCompanion.insert(
        id: 'prod-001',
        tenantId: 'tenant-001',
        code: 'PROD-001',
        name: 'Test Product',
      ));

      // Query products
      final products = await database.select(database.localProducts).get();
      expect(products.length, equals(1));
      expect(products.first.name, equals('Test Product'));
    });

    test('Can insert items to sync queue', () async {
      // Insert sync queue item
      await database.into(database.syncQueue).insert(SyncQueueCompanion.insert(
        entityType: 'sale',
        entityId: 'sale-001',
        operation: 'create',
        payload: '{"id": "sale-001"}',
      ));

      // Query sync queue
      final queue = await database.select(database.syncQueue).get();
      expect(queue.length, equals(1));
      expect(queue.first.entityType, equals('sale'));
      expect(queue.first.retryCount, equals(0));
    });

    test('Tables have correct structure', () async {
      // Verify tables exist by querying them
      final sales = await database.select(database.localSales).get();
      final products = await database.select(database.localProducts).get();
      final variants = await database.select(database.localProductVariants).get();
      final saleItems = await database.select(database.localSaleItems).get();
      final queue = await database.select(database.syncQueue).get();

      // All queries should succeed (tables exist)
      expect(sales, isA<List>());
      expect(products, isA<List>());
      expect(variants, isA<List>());
      expect(saleItems, isA<List>());
      expect(queue, isA<List>());
    });
  });

  group('Offline-First Features', () {
    test('Sales default to synced = false', () async {
      await database.into(database.localSales).insert(LocalSalesCompanion.insert(
        id: 'offline-sale',
        tenantId: 'tenant-001',
        branchId: 'branch-001',
        cashierId: 'cashier-001',
        localId: 'local-offline',
      ));

      final sale = await (database.select(database.localSales)
        ..where((s) => s.id.equals('offline-sale')))
        .getSingle();

      expect(sale.synced, equals(false));
      expect(sale.syncedAt, isNull);
    });

    test('Sales default status is draft', () async {
      await database.into(database.localSales).insert(LocalSalesCompanion.insert(
        id: 'draft-sale',
        tenantId: 'tenant-001',
        branchId: 'branch-001',
        cashierId: 'cashier-001',
        localId: 'local-draft',
      ));

      final sale = await (database.select(database.localSales)
        ..where((s) => s.id.equals('draft-sale')))
        .getSingle();

      expect(sale.status, equals('draft'));
    });
  });
}
