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
      expect(database.schemaVersion, equals(2));
    });

// ... (skipping unchanged tests)

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

      expect(sale.status, equals(SaleStatus.draft));
    });
  });
}
