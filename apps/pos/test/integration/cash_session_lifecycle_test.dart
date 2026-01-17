// =============================================================================
// E2E Integration Test: Cash Session Lifecycle
// =============================================================================
// Tests the complete cash session lifecycle from opening to closing.
// Includes income, expense, withdrawal, blind reconciliation (RF-007).
// =============================================================================

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:mockito/mockito.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/data/sync/sync_service.dart';
import 'package:pos/data/api/api_client.dart';
import 'package:pos/services/cash_session_service.dart';
import 'package:pos/services/sales_service.dart';
import 'package:pos/services/stock_service.dart';
import 'package:pos/services/fifo_service.dart';
import 'package:pos/services/stock_reservation_service.dart';
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
  late CashSessionService cashSessionService;
  late SalesService salesService;
  late StockService stockService;
  late FifoService fifoService;
  late StockReservationService reservationService;
  late MockSyncService mockSyncService;
  late MockApiClient mockApiClient;
  const uuid = Uuid();

  // Test data
  late String testTenantId;
  late String testBranchId;
  late String testUserId;
  late String testCashRegisterId;
  late String testVariantId;
  late String testLotId;

  setUp(() async {
    // Initialize IDs
    testTenantId = uuid.v4();
    testBranchId = uuid.v4();
    testUserId = uuid.v4();
    testCashRegisterId = uuid.v4();
    testVariantId = uuid.v4();
    testLotId = uuid.v4();

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
    final categoryId = uuid.v4();
    await database.into(database.localProductCategories).insert(
          LocalProductCategoriesCompanion.insert(
            id: categoryId,
            tenantId: testTenantId,
            name: 'Bebidas',
            code: const Value('BEB'),
          ),
        );

    // 3. Create product
    final productId = uuid.v4();
    await database.into(database.localProducts).insert(
          LocalProductsCompanion.insert(
            id: productId,
            tenantId: testTenantId,
            name: 'Coca Cola 350ml',
            code: 'PROD-001',
            categoryId: Value(categoryId),
            trackInventory: const Value(true),
          ),
        );

    // 4. Create variant
    await database.into(database.localProductVariants).insert(
          LocalProductVariantsCompanion.insert(
            id: testVariantId,
            tenantId: testTenantId,
            productId: productId,
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
  });

  tearDown(() async {
    await database.close();
  });

  group('Cash Session Lifecycle E2E', () {
    test(
        'Complete session lifecycle: open, sales, movements, close with balance',
        () async {
      // === 1. OPEN SESSION ===
      final session = await cashSessionService.openSession(
        tenantId: testTenantId,
        cashRegisterId: testCashRegisterId,
        userId: testUserId,
        initialAmount: 100000, // $100,000 initial fund
      );

      expect(session.id, isNotEmpty);
      expect(session.status, SessionStatus.open);
      expect(session.initialAmount, 100000);
      expect(session.systemAmount, 100000);

      // Verify initial movement was created
      final initialMovements =
          await database.select(database.localCashMovements).get();
      expect(initialMovements.length, 1);
      expect(initialMovements.first.concept, contains('Apertura'));

      // === 2. MAKE SALES ===
      final sale1 = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: session.id,
        items: [
          SaleItemDto(
              variantId: testVariantId,
              quantity: 10,
              unitPrice: 3500,
              productName: 'Coca Cola'),
        ],
        payments: [
          PaymentDto(method: PaymentMethod.cash, amount: 41650)
        ], // 35000 * 1.19
        discountAmount: 0,
      );
      await salesService.createSale(sale1, testTenantId);

      final sale2 = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: session.id,
        items: [
          SaleItemDto(
              variantId: testVariantId,
              quantity: 5,
              unitPrice: 3500,
              productName: 'Coca Cola'),
        ],
        payments: [
          PaymentDto(method: PaymentMethod.cash, amount: 20825)
        ], // 17500 * 1.19
        discountAmount: 0,
      );
      await salesService.createSale(sale2, testTenantId);

      // === 3. RECORD INCOME ===
      await cashSessionService.recordIncome(
        sessionId: session.id,
        amount: 5000,
        concept: 'Pago de cliente a crédito',
        userId: testUserId,
      );

      // === 4. RECORD EXPENSE ===
      await cashSessionService.recordExpense(
        sessionId: session.id,
        amount: 8000,
        concept: 'Compra de bolsas',
        userId: testUserId,
      );

      // === 5. RECORD WITHDRAWAL ===
      await cashSessionService.recordWithdrawal(
        sessionId: session.id,
        amount: 50000,
        concept: 'Retiro para depósito bancario',
        userId: testUserId,
      );

      // === 6. VERIFY SYSTEM AMOUNT ===
      final systemAmount = await cashSessionService.calculateSystemAmount(
        sessionId: session.id,
      );
      // Expected: 100000 + 41650 + 20825 + 5000 - 8000 - 50000 = 109475
      expect(systemAmount, closeTo(109475, 1));

      // === 7. GET SESSION SUMMARY ===
      final summary =
          await cashSessionService.getSessionSummary(sessionId: session.id);
      expect(summary.session.initialAmount, 100000);
      // 100000 (Open) + 41650 (Sale 1) + 20825 (Sale 2) + 5000 (Income) = 167475
      expect(summary.totalIncome, closeTo(167475, 1));
      expect(summary.totalExpenses, 8000);
      expect(summary.totalWithdrawals, 50000);
      expect(summary.currentSystemAmount, closeTo(109475, 1));

      // === 8. CLOSE SESSION - BALANCED ===
      final closeResult = await cashSessionService.closeSession(
        sessionId: session.id,
        declaredAmount: 109475, // Exact match
      );

      expect(closeResult.isBalanced, isTrue);
      expect(closeResult.hasShortage, isFalse);
      expect(closeResult.hasExcess, isFalse);
      expect(closeResult.difference, closeTo(0, 1));
      expect(closeResult.requiresApproval, isFalse);

      // Verify session is closed
      expect(await cashSessionService.hasOpenSession(testUserId), isFalse);

      // Verify sync was queued
      expect(
        mockSyncService.queuedItems.any((item) =>
            item['entityType'] == 'cash_session' &&
            item['operation'] == 'update'),
        isTrue,
      );
    });

    test('Close session with shortage requires justification', () async {
      // Open session
      final session = await cashSessionService.openSession(
        tenantId: testTenantId,
        cashRegisterId: testCashRegisterId,
        userId: testUserId,
        initialAmount: 100000,
      );

      // Make a sale
      final sale = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: session.id,
        items: [
          SaleItemDto(
              variantId: testVariantId,
              quantity: 10,
              unitPrice: 3500,
              productName: 'Coca Cola'),
        ],
        payments: [PaymentDto(method: PaymentMethod.cash, amount: 41650)],
        discountAmount: 0,
      );
      await salesService.createSale(sale, testTenantId);

      // System amount should be 141650
      final systemAmount =
          await cashSessionService.calculateSystemAmount(sessionId: session.id);
      expect(systemAmount, closeTo(141650, 1));

      // Close with shortage (declared less than system)
      final closeResult = await cashSessionService.closeSession(
        sessionId: session.id,
        declaredAmount: 140000, // $1650 shortage
        justification: 'Error en cambio entregado',
      );

      expect(closeResult.isBalanced, isFalse);
      expect(closeResult.hasShortage, isTrue);
      expect(closeResult.difference, closeTo(-1650, 1));
      expect(closeResult.requiresApproval, isTrue);
    });

    test('Close session with excess', () async {
      // Open session
      final session = await cashSessionService.openSession(
        tenantId: testTenantId,
        cashRegisterId: testCashRegisterId,
        userId: testUserId,
        initialAmount: 100000,
      );

      // Close with excess (declared more than system)
      final closeResult = await cashSessionService.closeSession(
        sessionId: session.id,
        declaredAmount: 102000, // $2000 excess
      );

      expect(closeResult.isBalanced, isFalse);
      expect(closeResult.hasExcess, isTrue);
      expect(closeResult.difference, closeTo(2000, 1));
      expect(closeResult.requiresApproval, isTrue);
    });

    test('Cannot open session if user already has one open', () async {
      // Open first session
      await cashSessionService.openSession(
        tenantId: testTenantId,
        cashRegisterId: testCashRegisterId,
        userId: testUserId,
        initialAmount: 100000,
      );

      // Try to open another
      expect(
        () => cashSessionService.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 50000,
        ),
        throwsA(isA<CashSessionException>()),
      );
    });

    test('Cannot open session if register already in use', () async {
      final anotherUserId = uuid.v4();

      // User 1 opens session on register
      await cashSessionService.openSession(
        tenantId: testTenantId,
        cashRegisterId: testCashRegisterId,
        userId: testUserId,
        initialAmount: 100000,
      );

      // User 2 tries to use same register
      expect(
        () => cashSessionService.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: anotherUserId,
          initialAmount: 50000,
        ),
        throwsA(isA<CashSessionException>()),
      );
    });

    test('Card payments do not affect cash balance', () async {
      // Open session
      final session = await cashSessionService.openSession(
        tenantId: testTenantId,
        cashRegisterId: testCashRegisterId,
        userId: testUserId,
        initialAmount: 100000,
      );

      // Make sale with card payment
      final sale = CreateSaleDto(
        branchId: testBranchId,
        cashierId: testUserId,
        cashSessionId: session.id,
        items: [
          SaleItemDto(
              variantId: testVariantId,
              quantity: 10,
              unitPrice: 3500,
              productName: 'Coca Cola'),
        ],
        payments: [PaymentDto(method: PaymentMethod.card, amount: 41650)],
        discountAmount: 0,
      );
      await salesService.createSale(sale, testTenantId);

      // System amount should still be 100000 (card doesn't affect cash)
      final systemAmount =
          await cashSessionService.calculateSystemAmount(sessionId: session.id);
      expect(systemAmount, closeTo(100000, 1));
    });

    test('All movements are queued for sync', () async {
      mockSyncService.queuedItems.clear();

      // Open session
      final session = await cashSessionService.openSession(
        tenantId: testTenantId,
        cashRegisterId: testCashRegisterId,
        userId: testUserId,
        initialAmount: 100000,
      );

      // Record various movements
      await cashSessionService.recordIncome(
        sessionId: session.id,
        amount: 5000,
        concept: 'Ingreso test',
        userId: testUserId,
      );

      await cashSessionService.recordExpense(
        sessionId: session.id,
        amount: 3000,
        concept: 'Gasto test',
        userId: testUserId,
      );

      await cashSessionService.recordWithdrawal(
        sessionId: session.id,
        amount: 10000,
        concept: 'Retiro test',
        userId: testUserId,
      );

      // Verify all movements were queued
      final movementSyncs = mockSyncService.queuedItems
          .where((item) => item['entityType'] == 'cash_movement')
          .toList();

      // 1 initial + 3 manual = 4 movements
      expect(movementSyncs.length, 4);
    });
  });
}
