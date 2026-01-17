import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:mockito/mockito.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/data/sync/sync_service.dart';
import 'package:pos/services/cash_session_service.dart';
import 'package:uuid/uuid.dart';

class MockSyncService extends Mock implements SyncService {
  @override
  Future<void> queueForSync({
    required String? entityType,
    required String? entityId,
    required String? operation,
    required Map<String, dynamic>? payload,
  }) async {
    return Future.value();
  }
}

void main() {
  late AppDatabase database;
  late CashSessionService service;
  late MockSyncService mockSyncService;
  const uuid = Uuid();

  final testTenantId = uuid.v4();
  final testUserId = uuid.v4();
  final testCashRegisterId = uuid.v4();

  setUp(() async {
    // Use in-memory SQLite database for testing
    database = AppDatabase.forTesting(NativeDatabase.memory());
    mockSyncService = MockSyncService();
    service = CashSessionService(
      database: database,
      syncService: mockSyncService,
    );

    // Create a cash register for testing
    await database.into(database.localCashRegisters).insert(
          LocalCashRegistersCompanion.insert(
            id: testCashRegisterId,
            tenantId: testTenantId,
            branchId: uuid.v4(),
            code: 'CAJA-01',
            name: 'Caja Principal',
          ),
        );
  });

  tearDown(() async {
    await database.close();
  });

  group('CashSessionService', () {
    group('getDefaultRegister', () {
      test('returns active register', () async {
        final register = await service.getDefaultRegister();
        expect(register, isNotNull);
        expect(register!.id, testCashRegisterId);
      });

      test('returns null if no active register', () async {
        // Deactivate the register
        await database.update(database.localCashRegisters).write(
              LocalCashRegistersCompanion(
                isActive: const Value(false),
              ),
            );

        final register = await service.getDefaultRegister();
        expect(register, isNull);
      });
    });

    group('hasOpenSession', () {
      test('returns true if session is open', () async {
        await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100,
        );
        expect(await service.hasOpenSession(testUserId), isTrue);
      });

      test('returns false if no session open', () async {
        expect(await service.hasOpenSession(testUserId), isFalse);
      });
    });

    group('openSession', () {
      test('opens a new session with initial amount', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        expect(session.tenantId, testTenantId);
        expect(session.cashRegisterId, testCashRegisterId);
        expect(session.userId, testUserId);
        expect(session.initialAmount, 100000);
        expect(session.systemAmount, 100000);
        expect(session.status, SessionStatus.open);
      });

      test('throws error when user already has open session', () async {
        await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await expectLater(
          service.openSession(
            tenantId: testTenantId,
            cashRegisterId: uuid.v4(), // Different register
            userId: testUserId, // Same user
            initialAmount: 50000,
          ),
          throwsA(isA<CashSessionException>()),
        );
      });

      test('throws error when cash register is in use', () async {
        await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await expectLater(
          service.openSession(
            tenantId: testTenantId,
            cashRegisterId: testCashRegisterId, // Same register
            userId: uuid.v4(), // Different user
            initialAmount: 50000,
          ),
          throwsA(isA<CashSessionException>()),
        );
      });
    });

    group('getActiveSession', () {
      test('returns null when no session exists', () async {
        final session = await service.getActiveSession(userId: testUserId);
        expect(session, isNull);
      });

      test('returns session when one exists', () async {
        await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        final session = await service.getActiveSession(userId: testUserId);
        expect(session, isNotNull);
        expect(session!.userId, testUserId);
      });
    });

    group('recordSaleInSession', () {
      test('increases system_amount correctly', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await service.recordSaleInSession(
          sessionId: session.id,
          cashAmount: 50000,
        );

        final updatedSession =
            await service.getActiveSession(userId: testUserId);
        expect(updatedSession!.systemAmount, 150000);
      });

      test('does nothing for zero or negative amount', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await service.recordSaleInSession(
          sessionId: session.id,
          cashAmount: 0,
        );

        final updatedSession =
            await service.getActiveSession(userId: testUserId);
        expect(updatedSession!.systemAmount, 100000);
      });
    });

    group('recordIncome', () {
      test('increases system amount and creates income movement', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100.0,
        );

        await service.recordIncome(
          sessionId: session.id,
          amount: 50.0,
          concept: 'Manual Income',
          userId: testUserId,
        );

        final updatedSession =
            await database.select(database.localCashSessions).getSingle();
        final movements =
            await service.getSessionMovements(sessionId: session.id);

        expect(updatedSession.systemAmount, 150.0);
        expect(updatedSession.systemAmount, 150.0);
        expect(movements.length, 2); // Initial + Income

        final incomeMovement =
            movements.firstWhere((m) => m.concept == 'Manual Income');
        expect(incomeMovement.movementType, CashMovementType.income);
        expect(incomeMovement.amount, 50.0);
      });

      test('throws error for invalid amount', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100.0,
        );

        expect(
          () => service.recordIncome(
            sessionId: session.id,
            amount: -10.0,
            concept: 'Invalid',
            userId: testUserId,
          ),
          throwsA(isA<CashSessionException>()),
        );
      });
    });

    group('recordWithdrawal', () {
      test('decreases system_amount correctly', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await service.recordWithdrawal(
          sessionId: session.id,
          amount: 30000,
          concept: 'Retiro para consignación',
          userId: testUserId,
        );

        final updatedSession =
            await service.getActiveSession(userId: testUserId);
        expect(updatedSession!.systemAmount, 70000);

        final movements = await service.getSessionMovements(
          sessionId: session.id,
        );
        expect(
            movements
                .where((m) => m.movementType == CashMovementType.withdrawal)
                .length,
            1);
      });

      test('throws error for invalid amount', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await expectLater(
          service.recordWithdrawal(
            sessionId: session.id,
            amount: 0,
            concept: 'Invalid',
            userId: testUserId,
          ),
          throwsA(isA<CashSessionException>()),
        );
      });
    });

    group('recordExpense', () {
      test('decreases system_amount correctly', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await service.recordExpense(
          sessionId: session.id,
          amount: 15000,
          concept: 'Compra de insumos',
          userId: testUserId,
          category: CashMovementCategory.expense,
        );

        final updatedSession =
            await service.getActiveSession(userId: testUserId);
        expect(updatedSession!.systemAmount, 85000);
      });
    });

    group('closeSession', () {
      test('closes session with matching amounts (balanced)', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await service.recordSaleInSession(
          sessionId: session.id,
          cashAmount: 50000,
        );

        final result = await service.closeSession(
          sessionId: session.id,
          declaredAmount: 150000,
        );

        expect(result.systemAmount, 150000);
        expect(result.declaredAmount, 150000);
        expect(result.difference, 0);
        expect(result.isBalanced, isTrue);
        expect(result.requiresApproval, isFalse);
      });

      test('closes session with shortage (requires approval)', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        final result = await service.closeSession(
          sessionId: session.id,
          declaredAmount: 95000, // 5000 short
          justification: 'Money was stolen',
        );

        expect(result.systemAmount, 100000);
        expect(result.declaredAmount, 95000);
        expect(result.difference, -5000);
        expect(result.hasShortage, isTrue);
        expect(result.requiresApproval, isTrue);
      });

      test('closes session with excess (requires approval)', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        final result = await service.closeSession(
          sessionId: session.id,
          declaredAmount: 102000, // 2000 extra
        );

        expect(result.systemAmount, 100000);
        expect(result.declaredAmount, 102000);
        expect(result.difference, 2000);
        expect(result.hasExcess, isTrue);
        expect(result.requiresApproval, isTrue);
      });
    });

    group('getSessionSummary', () {
      test('calculates summary correctly', () async {
        final session = await service.openSession(
          tenantId: testTenantId,
          cashRegisterId: testCashRegisterId,
          userId: testUserId,
          initialAmount: 100000,
        );

        await service.recordSaleInSession(
          sessionId: session.id,
          cashAmount: 50000,
        );

        await service.recordWithdrawal(
          sessionId: session.id,
          amount: 20000,
          concept: 'Retiro',
          userId: testUserId,
        );

        final summary = await service.getSessionSummary(
          sessionId: session.id,
        );

        expect(summary.session.id, session.id);
        expect(summary.currentSystemAmount, 130000); // 100k + 50k - 20k
        expect(summary.totalWithdrawals, 20000);
      });
    });
  });
}
