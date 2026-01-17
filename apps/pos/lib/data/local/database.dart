// =============================================================================
// QFlow POS - Drift Database
// =============================================================================
// Main database definition using modular table imports
// =============================================================================

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Import all table definitions from modular files
import 'tables/tables.dart';

// Re-export enums for convenience
export 'tables/enums.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    // Catalog
    LocalProductCategories,
    LocalBrands,
    LocalUnitsOfMeasure,
    // Products
    LocalProducts,
    LocalProductVariants,
    // Pricing
    LocalPriceLists,
    LocalPriceListItems,
    // Inventory
    LocalInventoryLots,
    LocalInventoryMovements,
    // Customers
    LocalCustomers,
    // Sales
    LocalSales,
    LocalSaleItems,
    LocalSalePayments,
    // Orders (B2B) - for stock reservations
    LocalOrders,
    LocalOrderItems,
    // Cash Management
    LocalCashRegisters,
    LocalCashSessions,
    LocalCashMovements,
    // Sync
    SyncQueue,
    SyncConflicts,
    SyncAudit,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing with in-memory database
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 6; // Incremented for SyncAudit

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // In development, recreate all tables on schema change
        // For production, implement proper migrations
        if (from < 3) {
          // Drop all and recreate for the modular refactor
          await m.createAll();
        }
      },
      beforeOpen: (details) async {
        // Enable foreign keys
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

/// Opens a lazy database connection with the SQLite file
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'qflow_pos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
