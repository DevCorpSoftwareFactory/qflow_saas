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
      expect(database.schemaVersion, equals(6)); // Updated for sync tables
    });

    test('Sales default status is completed (POS immediate sales)', () async {
      await database
          .into(database.localSales)
          .insert(LocalSalesCompanion.insert(
            id: 'test-sale',
            tenantId: 'tenant-001',
            branchId: 'branch-001',
            cashierId: 'cashier-001',
            localId: 'local-test',
          ));

      final sale = await (database.select(database.localSales)
            ..where((s) => s.id.equals('test-sale')))
          .getSingle();

      // POS sales are completed immediately (not draft)
      expect(sale.status, equals(SaleStatus.completed));
    });
  });
}
