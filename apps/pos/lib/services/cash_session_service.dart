import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../data/local/database.dart';
import '../data/sync/sync_service.dart';

/// Service for managing cash sessions (Apertura/Cierre de Caja).
///
/// Implements RF-007: Cuadre ciego (system_amount vs declared_amount)
/// - system_amount: Calculated by the system based on all movements
/// - declared_amount: What the cashier physically counts
/// - difference: declared_amount - system_amount (positive = excess, negative = shortage)
class CashSessionService {
  final AppDatabase _db;
  final SyncService _syncService;
  final _uuid = const Uuid();

  CashSessionService({
    required AppDatabase database,
    required SyncService syncService,
  })  : _db = database,
        _syncService = syncService;

  /// Get the default cash register (currently just the first active one found).
  /// In a real scenario, this would filter by device ID or current branch config.
  Future<LocalCashRegister?> getDefaultRegister() async {
    return (_db.select(_db.localCashRegisters)
          ..where((r) => r.isActive.equals(true))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Check if a user has an open session.
  Future<bool> hasOpenSession(String userId) async {
    final session = await getActiveSession(userId: userId);
    return session != null;
  }

  /// Open a new cash session for a cash register.
  /// A user can only have one open session at a time.
  Future<LocalCashSession> openSession({
    required String tenantId,
    required String cashRegisterId,
    required String userId,
    required double initialAmount,
  }) async {
    // Validate no existing open session for this user
    final existingSession = await getActiveSession(userId: userId);
    if (existingSession != null) {
      throw CashSessionException(
        'User already has an open cash session: ${existingSession.id}',
        code: 'SESSION_ALREADY_OPEN',
      );
    }

    // Validate no existing open session for this cash register
    final registerSession = await getActiveSessionForRegister(
      cashRegisterId: cashRegisterId,
    );
    if (registerSession != null) {
      throw CashSessionException(
        'Cash register already has an open session',
        code: 'REGISTER_IN_USE',
      );
    }

    final sessionId = _uuid.v4();

    final session = LocalCashSessionsCompanion.insert(
      id: sessionId,
      tenantId: tenantId,
      cashRegisterId: cashRegisterId,
      userId: userId,
      initialAmount: Value(initialAmount),
      systemAmount:
          Value(initialAmount), // Initial amount is the starting system amount
      status: const Value(SessionStatus.open),
      synced: const Value(false),
      localId: sessionId,
    );

    await _db.into(_db.localCashSessions).insert(session);

    // Create initial cash movement for the opening amount
    if (initialAmount > 0) {
      final movementId = _uuid.v4();
      final movement = LocalCashMovementsCompanion.insert(
        id: movementId,
        tenantId: tenantId,
        cashSessionId: Value(sessionId),
        movementType: CashMovementType.income,
        category: const Value(CashMovementCategory.other),
        amount: initialAmount,
        concept: 'Apertura de caja',
        createdBy: Value(userId),
        synced: const Value(false),
        localId: movementId,
      );
      await _db.into(_db.localCashMovements).insert(movement);

      await _syncService.queueForSync(
        entityType: 'cash_movement',
        entityId: movementId,
        operation: 'create',
        payload: {
          'id': movementId,
          'tenantId': tenantId,
          'cashSessionId': sessionId,
          'movementType': CashMovementType.income.name,
          'category': CashMovementCategory.other.name,
          'amount': initialAmount,
          'concept': 'Apertura de caja',
          'createdBy': userId,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );
    }

    final insertedSession = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingle();

    await _syncService.queueForSync(
      entityType: 'cash_session',
      entityId: sessionId,
      operation: 'create',
      payload: insertedSession.toJson(),
    );

    return insertedSession;
  }

  /// Get the active (open) session for a user.
  Future<LocalCashSession?> getActiveSession({required String userId}) async {
    return (_db.select(_db.localCashSessions)
          ..where((s) => s.userId.equals(userId))
          ..where((s) => s.status.equals(SessionStatus.open.name)))
        .getSingleOrNull();
  }

  /// Get the active session for a cash register.
  Future<LocalCashSession?> getActiveSessionForRegister({
    required String cashRegisterId,
  }) async {
    return (_db.select(_db.localCashSessions)
          ..where((s) => s.cashRegisterId.equals(cashRegisterId))
          ..where((s) => s.status.equals(SessionStatus.open.name)))
        .getSingleOrNull();
  }

  /// Record a sale in the cash session (increases system_amount for cash payments).
  /// Creates an income movement and updates the session's system_amount.
  Future<void> recordSaleInSession({
    required String sessionId,
    required double cashAmount,
    String? saleId,
  }) async {
    if (cashAmount <= 0) return;

    final session = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null) {
      throw CashSessionException(
        'Session not found: $sessionId',
        code: 'SESSION_NOT_FOUND',
      );
    }

    if (session.status != SessionStatus.open) {
      throw CashSessionException(
        'Cannot record sale in closed session',
        code: 'SESSION_CLOSED',
      );
    }

    // Create income movement for the sale
    final movementId = _uuid.v4();
    final movement = LocalCashMovementsCompanion.insert(
      id: movementId,
      tenantId: session.tenantId,
      cashSessionId: Value(sessionId),
      movementType: CashMovementType.income,
      category: const Value(CashMovementCategory.salesCash),
      amount: cashAmount,
      concept: 'Venta en efectivo',
      reference: Value(saleId),
      synced: const Value(false),
      localId: movementId,
    );
    await _db.into(_db.localCashMovements).insert(movement);

    // Update system_amount
    await (_db.update(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .write(LocalCashSessionsCompanion(
      systemAmount: Value(session.systemAmount + cashAmount),
      updatedAt: Value(DateTime.now()),
    ));

    await _syncService.queueForSync(
      entityType: 'cash_movement',
      entityId: movementId,
      operation: 'create',
      payload: {
        'id': movementId,
        'tenantId': session.tenantId,
        'cashSessionId': sessionId,
        'movementType': CashMovementType.income.name,
        'category': CashMovementCategory.salesCash.name,
        'amount': cashAmount,
        'concept': 'Venta en efectivo',
        'reference': saleId,
        'createdAt': DateTime.now().toIso8601String(),
      },
    );

    // Queue session update? Or rely on backend to update systemAmount?
    // Usually backend will update its systemAmount when it receives the movement.
    // BUT we also track systemAmount in session table locally.
    // If we sync session table update, we might overwrite backend calculation.
    // Let's assume we sync movements and backend recalculates, OR we sync session "snapshot".
    // For safety, let's sync the movement AND the session update (systemAmount).

    await _syncService.queueForSync(
      entityType: 'cash_session',
      entityId: sessionId,
      operation: 'update',
      payload: {
        'systemAmount': session.systemAmount + cashAmount,
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Record manual income in the cash session (e.g. adding change).
  Future<void> recordIncome({
    required String sessionId,
    required double amount,
    required String concept,
    required String userId,
    String? reference,
  }) async {
    if (amount <= 0) {
      throw CashSessionException(
        'Income amount must be positive',
        code: 'INVALID_AMOUNT',
      );
    }

    final session = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null || session.status != SessionStatus.open) {
      throw CashSessionException(
        'Session not found or closed',
        code: 'SESSION_INVALID',
      );
    }

    // Create income movement
    final movementId = _uuid.v4();
    final movement = LocalCashMovementsCompanion.insert(
      id: movementId,
      tenantId: session.tenantId,
      cashSessionId: Value(sessionId),
      movementType: CashMovementType.income,
      category: const Value(CashMovementCategory.other),
      amount: amount,
      concept: concept,
      reference: Value(reference),
      createdBy: Value(userId),
      synced: const Value(false),
      localId: movementId,
    );
    await _db.into(_db.localCashMovements).insert(movement);

    // Update system_amount
    await (_db.update(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .write(LocalCashSessionsCompanion(
      systemAmount: Value(session.systemAmount + amount),
      updatedAt: Value(DateTime.now()),
    ));

    await _syncService.queueForSync(
      entityType: 'cash_movement',
      entityId: movementId,
      operation: 'create',
      payload: {
        'id': movementId,
        'tenantId': session.tenantId,
        'cashSessionId': sessionId,
        'movementType': CashMovementType.income.name,
        'category': CashMovementCategory.other.name,
        'amount': amount,
        'concept': concept,
        'reference': reference,
        'createdBy': userId,
        'createdAt': DateTime.now().toIso8601String(),
      },
    );

    await _syncService.queueForSync(
      entityType: 'cash_session',
      entityId: sessionId,
      operation: 'update',
      payload: {
        'systemAmount': session.systemAmount + amount,
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Record a withdrawal from the cash session.
  Future<void> recordWithdrawal({
    required String sessionId,
    required double amount,
    required String concept,
    required String userId,
    String? reference,
  }) async {
    if (amount <= 0) {
      throw CashSessionException(
        'Withdrawal amount must be positive',
        code: 'INVALID_AMOUNT',
      );
    }

    final session = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null || session.status != SessionStatus.open) {
      throw CashSessionException(
        'Session not found or closed',
        code: 'SESSION_INVALID',
      );
    }

    // Create withdrawal movement
    final movementId = _uuid.v4();
    final movement = LocalCashMovementsCompanion.insert(
      id: movementId,
      tenantId: session.tenantId,
      cashSessionId: Value(sessionId),
      movementType: CashMovementType.withdrawal,
      amount: amount,
      concept: concept,
      reference: Value(reference),
      createdBy: Value(userId),
      synced: const Value(false),
      localId: movementId,
    );
    await _db.into(_db.localCashMovements).insert(movement);

    // Update system_amount (decrease)
    await (_db.update(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .write(LocalCashSessionsCompanion(
      systemAmount: Value(session.systemAmount - amount),
      updatedAt: Value(DateTime.now()),
    ));

    await _syncService.queueForSync(
      entityType: 'cash_movement',
      entityId: movementId,
      operation: 'create',
      payload: {
        'id': movementId,
        'tenantId': session.tenantId,
        'cashSessionId': sessionId,
        'movementType': CashMovementType.withdrawal.name,
        'amount': amount,
        'concept': concept,
        'reference': reference,
        'createdBy': userId,
        'createdAt': DateTime.now().toIso8601String(),
      },
    );

    await _syncService.queueForSync(
      entityType: 'cash_session',
      entityId: sessionId,
      operation: 'update',
      payload: {
        'systemAmount': session.systemAmount - amount,
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Record an expense from the cash session.
  Future<void> recordExpense({
    required String sessionId,
    required double amount,
    required String concept,
    required String userId,
    CashMovementCategory category = CashMovementCategory.expense,
    String? reference,
    String? evidenceUrl,
  }) async {
    if (amount <= 0) {
      throw CashSessionException(
        'Expense amount must be positive',
        code: 'INVALID_AMOUNT',
      );
    }

    final session = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null || session.status != SessionStatus.open) {
      throw CashSessionException(
        'Session not found or closed',
        code: 'SESSION_INVALID',
      );
    }

    // Create expense movement
    final movementId = _uuid.v4();
    final movement = LocalCashMovementsCompanion.insert(
      id: movementId,
      tenantId: session.tenantId,
      cashSessionId: Value(sessionId),
      movementType: CashMovementType.expense,
      category: Value(category),
      amount: amount,
      concept: concept,
      reference: Value(reference),
      evidenceUrl: Value(evidenceUrl),
      createdBy: Value(userId),
      synced: const Value(false),
      localId: movementId,
    );
    await _db.into(_db.localCashMovements).insert(movement);

    // Update system_amount (decrease)
    await (_db.update(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .write(LocalCashSessionsCompanion(
      systemAmount: Value(session.systemAmount - amount),
      updatedAt: Value(DateTime.now()),
    ));

    await _syncService.queueForSync(
      entityType: 'cash_movement',
      entityId: movementId,
      operation: 'create',
      payload: {
        'id': movementId,
        'tenantId': session.tenantId,
        'cashSessionId': sessionId,
        'movementType': CashMovementType.expense.name,
        'category': category.name,
        'amount': amount,
        'concept': concept,
        'reference': reference,
        'evidenceUrl': evidenceUrl,
        'createdBy': userId,
        'createdAt': DateTime.now().toIso8601String(),
      },
    );

    await _syncService.queueForSync(
      entityType: 'cash_session',
      entityId: sessionId,
      operation: 'update',
      payload: {
        'systemAmount': session.systemAmount - amount,
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Get all movements for a session.
  Future<List<LocalCashMovement>> getSessionMovements({
    required String sessionId,
  }) async {
    return (_db.select(_db.localCashMovements)
          ..where((m) => m.cashSessionId.equals(sessionId))
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
        .get();
  }

  /// Calculate the current system amount for a session based on movements.
  Future<double> calculateSystemAmount({required String sessionId}) async {
    final session = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null) return 0;

    final movements = await getSessionMovements(sessionId: sessionId);

    double total = 0;
    for (final movement in movements) {
      switch (movement.movementType) {
        case CashMovementType.income:
        case CashMovementType.transferIn:
          total += movement.amount;
          break;
        case CashMovementType.expense:
        case CashMovementType.withdrawal:
        case CashMovementType.transferOut:
          total -= movement.amount;
          break;
      }
    }

    return total;
  }

  /// Close a cash session with the declared amount.
  /// This implements the blind reconciliation (RF-007).
  Future<CashSessionCloseResult> closeSession({
    required String sessionId,
    required double declaredAmount,
    String? justification,
  }) async {
    final session = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null) {
      throw CashSessionException(
        'Session not found',
        code: 'SESSION_NOT_FOUND',
      );
    }

    if (session.status != SessionStatus.open) {
      throw CashSessionException(
        'Session is not open',
        code: 'SESSION_NOT_OPEN',
      );
    }

    // Recalculate system amount for accuracy
    final calculatedSystemAmount = await calculateSystemAmount(
      sessionId: sessionId,
    );

    final difference = declaredAmount - calculatedSystemAmount;
    final requiresApproval =
        difference.abs() > 0.01; // Any difference requires approval

    // Update session
    await (_db.update(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .write(LocalCashSessionsCompanion(
      closingDate: Value(DateTime.now()),
      systemAmount: Value(calculatedSystemAmount),
      declaredAmount: Value(declaredAmount),
      differenceJustification:
          difference.abs() > 0.01 ? Value(justification) : const Value(null),
      status: Value(
        requiresApproval ? SessionStatus.pendingApproval : SessionStatus.closed,
      ),
      updatedAt: Value(DateTime.now()),
    ));

    await _syncService.queueForSync(
      entityType: 'cash_session',
      entityId: sessionId,
      operation: 'update',
      payload: {
        'closingDate': DateTime.now().toIso8601String(),
        'systemAmount': calculatedSystemAmount,
        'declaredAmount': declaredAmount,
        'differenceJustification':
            difference.abs() > 0.01 ? justification : null,
        'status': requiresApproval
            ? SessionStatus.pendingApproval.name
            : SessionStatus.closed.name,
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );

    return CashSessionCloseResult(
      sessionId: sessionId,
      systemAmount: calculatedSystemAmount,
      declaredAmount: declaredAmount,
      difference: difference,
      requiresApproval: requiresApproval,
    );
  }

  /// Approve a session that is pending approval (admin action).
  Future<void> approveSession({
    required String sessionId,
    required String approverId,
    String? notes,
  }) async {
    await (_db.update(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .write(LocalCashSessionsCompanion(
      status: const Value(SessionStatus.closed),
      approvedBy: Value(approverId),
      approvedAt: Value(DateTime.now()),
      approvalNotes: Value(notes),
      updatedAt: Value(DateTime.now()),
    ));

    await _syncService.queueForSync(
      entityType: 'cash_session',
      entityId: sessionId,
      operation: 'update',
      payload: {
        'status': SessionStatus.closed.name,
        'approvedBy': approverId,
        'approvedAt': DateTime.now().toIso8601String(),
        'approvalNotes': notes,
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Get session summary for display.
  Future<CashSessionSummary> getSessionSummary({
    required String sessionId,
  }) async {
    final session = await (_db.select(_db.localCashSessions)
          ..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null) {
      throw CashSessionException(
        'Session not found',
        code: 'SESSION_NOT_FOUND',
      );
    }

    final movements = await getSessionMovements(sessionId: sessionId);

    double totalIncome = 0;
    double totalExpenses = 0;
    double totalWithdrawals = 0;
    int salesCount = 0;

    for (final movement in movements) {
      switch (movement.movementType) {
        case CashMovementType.income:
          totalIncome += movement.amount;
          if (movement.category == CashMovementCategory.salesCash) {
            salesCount++;
          }
          break;
        case CashMovementType.expense:
          totalExpenses += movement.amount;
          break;
        case CashMovementType.withdrawal:
          totalWithdrawals += movement.amount;
          break;
        default:
          break;
      }
    }

    return CashSessionSummary(
      session: session,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalWithdrawals: totalWithdrawals,
      salesCount: salesCount,
      movementsCount: movements.length,
      currentSystemAmount: session.systemAmount,
    );
  }
}

/// Exception for cash session operations.
class CashSessionException implements Exception {
  final String message;
  final String code;

  CashSessionException(this.message, {required this.code});

  @override
  String toString() => 'CashSessionException($code): $message';
}

/// Result of closing a cash session.
class CashSessionCloseResult {
  final String sessionId;
  final double systemAmount;
  final double declaredAmount;
  final double difference;
  final bool requiresApproval;

  const CashSessionCloseResult({
    required this.sessionId,
    required this.systemAmount,
    required this.declaredAmount,
    required this.difference,
    required this.requiresApproval,
  });

  bool get hasShortage => difference < -0.01;
  bool get hasExcess => difference > 0.01;
  bool get isBalanced => difference.abs() <= 0.01;
}

/// Summary of a cash session.
class CashSessionSummary {
  final LocalCashSession session;
  final double totalIncome;
  final double totalExpenses;
  final double totalWithdrawals;
  final int salesCount;
  final int movementsCount;
  final double currentSystemAmount;

  const CashSessionSummary({
    required this.session,
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalWithdrawals,
    required this.salesCount,
    required this.movementsCount,
    required this.currentSystemAmount,
  });

  double get netCashFlow => totalIncome - totalExpenses - totalWithdrawals;
}
