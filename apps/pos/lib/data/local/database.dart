// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// --- ENUMS (Matching Backend) ---

enum SaleStatus {
  draft,
  completed,
  cancelled,
  returned,
}

enum SaleType {
  retail,
  wholesale,
  order,
}

enum PaymentMethod {
  cash,
  card,
  transfer,
  nequi,
  credit,
}

enum SessionStatus {
  open,
  closed,
}

enum CashMovementType {
  cash_in,
  cash_out,
  cash_transfer,
}

enum CashMovementCategory {
  credit_granted,
  credit_payment,
  online_payment_received,
  sales_cash,
  expense,
  purchase,
  withdrawal,
  transfer_to_bank,
  other,
}

enum MovementType {
  purchase,
  sale,
  transfer_out,
  transfer_in,
  adjustment,
  return_customer,
  return_supplier,
  waste,
  internal_consumption,
}

// --- TABLES ---

/// Local sales table for offline-first POS
class LocalSales extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get saleNumber => text().nullable()();
  TextColumn get customerId => text().nullable()();
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get taxAmount => real().withDefault(const Constant(0))();
  RealColumn get discountAmount => real().withDefault(const Constant(0))();
  RealColumn get totalAmount => real().withDefault(const Constant(0))();
  
  // Strict Enum
  TextColumn get status => textEnum<SaleStatus>().withDefault(const Constant('completed'))();
  TextColumn get saleType => textEnum<SaleType>().withDefault(const Constant('retail'))();
  
  TextColumn get cashierId => text()();
  DateTimeColumn get saleDate => dateTime().withDefault(currentDateAndTime)();
  
  // Offline Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()(); // Local UUID for offline creation
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local sale items (Immutable Prices)
class LocalSaleItems extends Table {
  TextColumn get id => text()();
  TextColumn get saleId => text().references(LocalSales, #id)();
  TextColumn get variantId => text()();
  TextColumn get lotId => text().nullable()();
  IntColumn get quantity => integer()();
  
  /// Historical Unit Price (Immutable)
  RealColumn get unitPrice => real()();
  
  /// Cost at moment of sale
  RealColumn get costPrice => real().nullable()();
  
  RealColumn get discountPercent => real().withDefault(const Constant(0))();
  RealColumn get subtotal => real()();
  
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local sale payments
class LocalSalePayments extends Table {
  TextColumn get id => text()();
  TextColumn get saleId => text().references(LocalSales, #id)();
  
  // Strict Enum
  TextColumn get paymentMethod => textEnum<PaymentMethod>()(); 
  
  RealColumn get amount => real()();
  TextColumn get reference => text().nullable()();
  
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}


/// Product cache for offline access
class LocalProducts extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get code => text()();
  TextColumn get barcodeType => text().nullable()(); // EAN13, CODE128, etc.
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get shortName => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get brandId => text().nullable()();
  TextColumn get unitId => text().nullable()();
  BoolColumn get hasExpiry => boolean().withDefault(const Constant(false))();
  BoolColumn get hasBatchControl => boolean().withDefault(const Constant(true))();
  BoolColumn get trackInventory => boolean().withDefault(const Constant(true))();
  BoolColumn get isSalable => boolean().withDefault(const Constant(true))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastSync => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Product variants cache
class LocalProductVariants extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(LocalProducts, #id)();
  TextColumn get sku => text()();
  TextColumn get barcode => text().nullable()();
  TextColumn get attributes => text().withDefault(const Constant('{}'))();
  // We keep price here as a fallback/cache, although real prices are in PriceListItems
  RealColumn get price => real().withDefault(const Constant(0.0))(); 
  RealColumn get weightKg => real().nullable()();
  RealColumn get volumeLiters => real().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastSync => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local price lists (tarifas)
class LocalPriceLists extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get customerType => text().nullable()(); // retail, wholesale, vip
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get validFrom => dateTime().nullable()();
  DateTimeColumn get validTo => dateTime().nullable()();
  DateTimeColumn get lastSync => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local price list items (precios específicos)
class LocalPriceListItems extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get priceListId => text().references(LocalPriceLists, #id)();
  TextColumn get variantId => text().references(LocalProductVariants, #id)();
  RealColumn get price => real()();
  RealColumn get costPrice => real().nullable()();
  IntColumn get minQuantity => integer().withDefault(const Constant(1))();
  IntColumn get maxQuantity => integer().nullable()();
  RealColumn get volumeDiscountPercent => real().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastSync => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local customers for offline POS
class LocalCustomers extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get fullName => text()();
  TextColumn get taxId => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get priceListId => text().nullable().references(LocalPriceLists, #id)(); // Assigned tariff
  RealColumn get creditLimit => real().withDefault(const Constant(0))();
  RealColumn get availableCredit => real().withDefault(const Constant(0))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local cash registers
class LocalCashRegisters extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}

/// Local cash sessions (Blind Close)
class LocalCashSessions extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get cashRegisterId => text().references(LocalCashRegisters, #id)();
  TextColumn get userId => text()();
  
  RealColumn get initialAmount => real().withDefault(const Constant(0))();
  
  // Separation: System vs Declared
  RealColumn get systemAmount => real().withDefault(const Constant(0))();
  RealColumn get declaredAmount => real().nullable()();
  
  // Strict Enum
  TextColumn get status => textEnum<SessionStatus>().withDefault(const Constant('open'))(); // open, closed
  
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();
  DateTimeColumn get openingDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get closingDate => dateTime().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

/// Local cash movements
class LocalCashMovements extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get cashSessionId => text().nullable().references(LocalCashSessions, #id)();
  
  // Strict Enums
  TextColumn get movementType => textEnum<CashMovementType>()(); // cash_in, etc.
  TextColumn get category => textEnum<CashMovementCategory>().nullable()();
  
  RealColumn get amount => real()();
  TextColumn get concept => text()();
  
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

/// Local Inventory Movements (Kardex - Immutable)
class LocalInventoryMovements extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get variantId => text().references(LocalProductVariants, #id)();
  TextColumn get lotId => text().nullable()(); // simplified for POS
  
  TextColumn get movementType => textEnum<MovementType>()();
  IntColumn get quantity => integer()();
  
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get localId => text()();
  DateTimeColumn get movementDate => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Sync queue for pending operations
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // sale, payment, etc.
  TextColumn get entityId => text()();
  TextColumn get operation => text()(); // create, update, delete
  TextColumn get payload => text()(); // JSON payload
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastAttempt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
}

@DriftDatabase(tables: [
  LocalSales,
  LocalSaleItems,
  LocalProducts,
  LocalProductVariants,
  LocalPriceLists,
  LocalPriceListItems,
  LocalCustomers,
  LocalCashRegisters,
  LocalCashSessions,
  LocalCashMovements,
  LocalSalePayments,
  LocalInventoryMovements, // Added
  SyncQueue,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2; // Incremented for new enums and fields

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // In dev, we might just drop/recreate, but strictly we should add columns.
        // For now user just wants the definitions corrected.
        if (from < 2) {
           await m.createTable(localInventoryMovements);
           // Add missing columns to tables if they didn't exist
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'qflow_pos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
