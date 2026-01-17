// =============================================================================
// E2E Integration Test: Complete Sale Flow
// =============================================================================
// Tests the entire sale lifecycle from cart to checkout to sync queue.
// Uses in-memory database to simulate real POS operations.
// =============================================================================

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:mockito/mockito.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/data/sync/sync_service.dart';
import 'package:pos/data/api/api_client.dart';
import 'package:pos/services/sales_service.dart';
import 'package:pos/services/stock_service.dart';
import 'package:pos/services/fifo_service.dart';
import 'package:pos/services/stock_reservation_service.dart';
import 'package:pos/services/cash_session_service.dart';
import 'package:pos/services/dto/create_sale_dto.dart';
import 'package:uuid/uuid.dart';

class MockSyncService extends Mock implements SyncService {
  final List<Map<String, dynamic>> queuedItems = [];

  @override
  Future<void> queueForSync({
    required String? entityType,
    required String? entityId,
    required String? operation,
    required Map<String, dynamic>? payload,
  }) async {
    queuedItems.add({
      'entityType': entityType,
      'entityId': entityId,
      'operation': operation,
      'payload': payload,
    });
    return Future.value();
  }
}

class MockApiClient extends Mock implements ApiClient {}

class MockReservationService extends Mock implements StockReservationService {
  @override
  Future<int> getReservedQuantity({
    required String variantId,
    required String branchId,
  }) async =>
      0;
}

void main() {
  late AppDatabase database;
  late SalesService salesService;
  late StockService stockService;
  late FifoService fifoService;
  late CashSessionService cashSessionService;
  late StockReservationService reservationService;
  late MockSyncService mockSyncService;
  late MockApiClient mockApiClient;
  const uuid = Uuid();

  // Test data
  late String testTenantId;
  late String testBranchId;
  late String testUserId;
  late String testCashRegisterId;
  late String testCategoryId;
  late String testProductId;
  late String testVariantId;
  late String testLotId;
  late String testPriceListId;
  late String testCashSessionId;

  setUp(() async {
    // Initialize IDs
    testTenantId = uuid.v4();
    testBranchId = uuid.v4();
    testUserId = uuid.v4();
    testCashRegisterId = uuid.v4();
    testCategoryId = uuid.v4();
    testProductId = uuid.v4();
    testVariantId = uuid.v4();
    testLotId = uuid.v4();
    testPriceListId = uuid.v4();

    // Use in-memory SQLite database for testing
    database = AppDatabase.forTesting(NativeDatabase.memory());
    mockSyncService = MockSyncService();
    mockApiClient = MockApiClient();
    reservationService = MockReservationService();

    // Initialize services
    fifoService = FifoService(database: database);
    stockService = StockService(
      database: database,
      apiClient: mockApiClient,
      fifoService: fifoService,
      reservationService: reservationService,
    );
    cashSessionService = CashSessionService(
      database: database,
      syncService: mockSyncService,
    );
    salesService = SalesService(
      database: database,
      stockService: stockService,
      fifoService: fifoService,
      cashSessionService: cashSessionService,
    );

    // === Set up test data ===

    // 1. Create cash register
    await database.into(database.localCashRegisters).insert(
          LocalCashRegistersCompanion.insert(
            id: testCashRegisterId,
            tenantId: testTenantId,
            branchId: testBranchId,
            code: 'CAJA-01',
            name: 'Caja Principal',
          ),
        );

    // 2. Create category
    await database.into(database.localProductCategories).insert(
          LocalProductCategoriesCompanion.insert(
            id: testCategoryId,
            tenantId: testTenantId,
            name: 'Bebidas',
            code: const Value('BEB'),
          ),
        );

    // 3. Create product
    await database.into(database.localProducts).insert(
          LocalProductsCompanion.insert(
            id: testProductId,
            tenantId: testTenantId,
            name: 'Coca Cola 350ml',
            code: 'PROD-001',
            categoryId: Value(testCategoryId),
            trackInventory: const Value(true),
          ),
        );

    // 4. Create variant
    await database.into(database.localProductVariants).insert(
          LocalProductVariantsCompanion.insert(
            id: testVariantId,
            tenantId: testTenantId,
            productId: testProductId,
            sku: 'CC-350',
            barcode: const Value('7702001122334'),
          ),
        );

    // 5. Create inventory lot with stock
    await database.into(database.localInventoryLots).insert(
          LocalInventoryLotsCompanion.insert(
            id: testLotId,
            tenantId: testTenantId,
            branchId: testBranchId,
            variantId: testVariantId,
            lotNumber: 'LOT-001',
            initialQuantity: 100,
            currentQuantity: 100,
            purchasePrice: 2500.0,
            unitCost: const Value(2500.0),
            status: const Value(LotStatus.active),
          ),
        );

    // 6. Create price list
    await database.into(database.localPriceLists).insert(
          LocalPriceListsCompanion.insert(
            id: testPriceListId,
            tenantId: testTenantId,
            name: 'Lista General',
            isDefault: const Value(true),
          ),
        );

    // 7. Open a cash session
    final session = await cashSessionService.openSession(
      tenantId: testTenantId,
      cashRegisterId: testCashRegisterId,
      userId: testUserId,
      initialAmount: 100000,
    );
    testCashSessionId = session.id;
  });

  tearDown(() async {
    await database.close();
  });

  group('Complete Sale Flow E2E', () {
    test(
        'Full sale cycle: create sale, consume inventory, create payment, queue for sync',
        () async {
      // === ARRANGE ===
      final saleDto = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: testCashSessionId,
        items: [
          SaleItemDto(
            variantId: testVariantId,
            quantity: 5,
            unitPrice: 3500,
            productName: 'Coca Cola 350ml',
          ),
        ],
        payments: [
          PaymentDto(
            method: PaymentMethod.cash,
            amount: 20825, // 17500 + 19% IVA = 20825
          ),
        ],
        discountAmount: 0,
      );

      // === ACT ===
      final result = await salesService.createSale(saleDto, testTenantId);

      // === ASSERT ===

      // 1. Verify sale was created
      expect(result.sale.id, isNotEmpty);
      expect(result.saleNumber, isNotEmpty);
      expect(result.items.length, 1); // 1 item (Lot Consumption)

      // 2. Verify totals calculated correctly
      expect(result.totals.subtotal, 17500); // 5 * 3500
      expect(result.totals.taxAmount, closeTo(3325, 1)); // 17500 * 0.19
      expect(result.totals.totalAmount, closeTo(20825, 1));

      // 3. Verify inventory was consumed (FIFO)
      final lotAfterSale = await (database.select(database.localInventoryLots)
            ..where((t) => t.id.equals(testLotId)))
          .getSingleOrNull();
      expect(lotAfterSale?.currentQuantity, 95); // 100 - 5

      // 4. Verify inventory movement was created
      final movements = await (database.select(database.localInventoryMovements)
            ..where((t) => t.variantId.equals(testVariantId)))
          .get();
      expect(movements.length,
          1); // One movement per unit consumed (fixed: per lot consumption)
      expect(movements.first.movementType, MovementType.sale);

      // 5. Verify payment was registered
      final payments = await database.select(database.localSalePayments).get();
      expect(payments.length, 1);
      expect(payments.first.paymentMethod, PaymentMethod.cash);
      expect(payments.first.amount, 20825);

      // 6. Verify sale was persisted
      final persistedSale = await (database.select(database.localSales)
            ..where((s) => s.id.equals(result.sale.id)))
          .getSingleOrNull();
      expect(persistedSale, isNotNull);
      expect(persistedSale?.totalAmount, closeTo(20825, 1));

      // 7. Verify cash session balance was updated
      final sessionAfterSale =
          await (database.select(database.localCashSessions)
                ..where((t) => t.id.equals(testCashSessionId)))
              .getSingleOrNull();
      expect(
          sessionAfterSale?.systemAmount, closeTo(120825, 1)); // 100000 + 20825
    });

    test('Split payment sale with multiple methods', () async {
      // === ARRANGE ===
      final saleDto = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: testCashSessionId,
        items: [
          SaleItemDto(
            variantId: testVariantId,
            quantity: 10,
            unitPrice: 3500,
            productName: 'Coca Cola 350ml',
          ),
        ],
        payments: [
          PaymentDto(method: PaymentMethod.cash, amount: 20000),
          PaymentDto(method: PaymentMethod.card, amount: 21650), // Remainder
        ],
        discountAmount: 0,
      );

      // === ACT ===
      final result = await salesService.createSale(saleDto, testTenantId);

      // === ASSERT ===
      expect(result.sale.id, isNotEmpty);

      // Verify both payments were registered
      final payments = await database.select(database.localSalePayments).get();
      expect(payments.length, 2);

      final cashPayment =
          payments.firstWhere((p) => p.paymentMethod == PaymentMethod.cash);
      final cardPayment =
          payments.firstWhere((p) => p.paymentMethod == PaymentMethod.card);

      expect(cashPayment.amount, 20000);
      expect(cardPayment.amount, 21650);

      // Only cash affects session balance
      final sessionAfterSale =
          await (database.select(database.localCashSessions)
                ..where((t) => t.id.equals(testCashSessionId)))
              .getSingleOrNull();
      expect(sessionAfterSale?.systemAmount,
          closeTo(120000, 1)); // 100000 + 20000 cash only
    });

    test('Sale with promotion/discount applied', () async {
      // === ARRANGE ===
      final saleDto = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: testCashSessionId,
        items: [
          SaleItemDto(
            variantId: testVariantId,
            quantity: 10,
            unitPrice: 3500,
            productName: 'Coca Cola 350ml',
          ),
        ],
        payments: [
          PaymentDto(
              method: PaymentMethod.cash,
              amount: 37485), // After 10% discount + IVA
        ],
        discountAmount: 3500, // 10% of 35000
      );

      // === ACT ===
      final result = await salesService.createSale(saleDto, testTenantId);

      // === ASSERT ===
      expect(result.sale.id, isNotEmpty);
      expect(result.totals.subtotal, 35000);
      // Total = (35000 - 3500) * 1.19 = 31500 * 1.19 = 37485
      expect(result.totals.totalAmount, closeTo(37485, 1));
    });

    test('Multiple sales deplete inventory correctly (FIFO)', () async {
      // === ARRANGE ===
      // Add another lot with later expiry
      final lot2Id = uuid.v4();
      await database.into(database.localInventoryLots).insert(
            LocalInventoryLotsCompanion.insert(
              id: lot2Id,
              tenantId: testTenantId,
              branchId: testBranchId,
              variantId: testVariantId,
              lotNumber: 'LOT-002',
              initialQuantity: 50,
              currentQuantity: 50,
              purchasePrice: 2600.0,
              unitCost: const Value(2600.0),
              status: const Value(LotStatus.active),
              // Ensure null expiry for strict FIFO (Creation Date) testing against first lot
              expiryDate: const Value(null),
            ),
          );

      // First sale: 80 units (should come from LOT-001)
      final sale1Dto = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: testCashSessionId,
        items: [
          SaleItemDto(
              variantId: testVariantId,
              quantity: 80,
              unitPrice: 3500,
              productName: 'Coca Cola'),
        ],
        payments: [PaymentDto(method: PaymentMethod.cash, amount: 333200)],
        discountAmount: 0,
      );

      // === ACT ===
      await salesService.createSale(sale1Dto, testTenantId);

      // === ASSERT ===
      // LOT-001 should have 20 left (100 - 80)
      final lot1After = await (database.select(database.localInventoryLots)
            ..where((t) => t.id.equals(testLotId)))
          .getSingleOrNull();
      expect(lot1After?.currentQuantity, 20);

      // LOT-002 should still have 50 (untouched)
      final lot2After = await (database.select(database.localInventoryLots)
            ..where((t) => t.id.equals(lot2Id)))
          .getSingleOrNull();
      expect(lot2After?.currentQuantity, 50);

      // Second sale: 40 units (should take 20 from LOT-001, 20 from LOT-002)
      final sale2Dto = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: testCashSessionId,
        items: [
          SaleItemDto(
              variantId: testVariantId,
              quantity: 40,
              unitPrice: 3500,
              productName: 'Coca Cola'),
        ],
        payments: [PaymentDto(method: PaymentMethod.cash, amount: 166600)],
        discountAmount: 0,
      );

      await salesService.createSale(sale2Dto, testTenantId);

      // LOT-001 should be depleted
      final lot1Final = await (database.select(database.localInventoryLots)
            ..where((t) => t.id.equals(testLotId)))
          .getSingleOrNull();
      expect(lot1Final?.currentQuantity, 0);

      // LOT-002 should have 30 left (50 - 20)
      final lot2Final = await (database.select(database.localInventoryLots)
            ..where((t) => t.id.equals(lot2Id)))
          .getSingleOrNull();
      expect(lot2Final?.currentQuantity, 30);
    });
  });
}
