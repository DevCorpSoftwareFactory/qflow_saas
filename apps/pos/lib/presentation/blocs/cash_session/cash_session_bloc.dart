import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';

import '../../../services/cash_session_service.dart';
import '../../../data/local/database.dart';

// ============================================================================
// EVENTS
// ============================================================================

abstract class CashSessionEvent extends Equatable {
  const CashSessionEvent();
  @override
  List<Object?> get props => [];
}

/// Check for existing open session.
class CashSessionCheckRequested extends CashSessionEvent {
  final String userId;
  const CashSessionCheckRequested(this.userId);
  @override
  List<Object?> get props => [userId];
}

/// Open a new cash session.
class CashSessionOpenRequested extends CashSessionEvent {
  final String tenantId;
  final String cashRegisterId;
  final String userId;
  final double initialAmount;

  const CashSessionOpenRequested({
    required this.tenantId,
    required this.cashRegisterId,
    required this.userId,
    required this.initialAmount,
  });

  @override
  List<Object?> get props => [tenantId, cashRegisterId, userId, initialAmount];
}

/// Record manual income.
class CashSessionIncomeRequested extends CashSessionEvent {
  final double amount;
  final String concept;
  final String userId;
  final String? reference;

  const CashSessionIncomeRequested({
    required this.amount,
    required this.concept,
    required this.userId,
    this.reference,
  });

  @override
  List<Object?> get props => [amount, concept, userId, reference];
}

class CashSessionWithdrawalRequested extends CashSessionEvent {
  final double amount;
  final String concept;
  final String userId;
  final String? reference;

  const CashSessionWithdrawalRequested({
    required this.amount,
    required this.concept,
    required this.userId,
    this.reference,
  });

  @override
  List<Object?> get props => [amount, concept, userId, reference];
}

/// Record an expense.
class CashSessionExpenseRequested extends CashSessionEvent {
  final double amount;
  final String concept;
  final String userId;
  final CashMovementCategory? category;
  final String? reference;

  const CashSessionExpenseRequested({
    required this.amount,
    required this.concept,
    required this.userId,
    this.category,
    this.reference,
  });

  @override
  List<Object?> get props => [amount, concept, userId, category, reference];
}

/// Close the current session.
class CashSessionCloseRequested extends CashSessionEvent {
  final double declaredAmount;
  final String? justification;

  const CashSessionCloseRequested({
    required this.declaredAmount,
    this.justification,
  });

  @override
  List<Object?> get props => [declaredAmount, justification];
}

/// Refresh session summary.
class CashSessionRefreshRequested extends CashSessionEvent {}

// ============================================================================
// STATES
// ============================================================================

abstract class CashSessionState extends Equatable {
  const CashSessionState();
  @override
  List<Object?> get props => [];
}

/// Initial state, no session checked yet.
class CashSessionInitial extends CashSessionState {}

/// Loading state during operations.
class CashSessionLoading extends CashSessionState {}

/// No active session for the current user.
class CashSessionNone extends CashSessionState {}

/// Active session with summary.
class CashSessionActive extends CashSessionState {
  final String sessionId;
  final CashSessionSummary summary;

  const CashSessionActive({
    required this.sessionId,
    required this.summary,
  });

  @override
  List<Object?> get props => [sessionId, summary];
}

/// Session closed with result.
class CashSessionClosed extends CashSessionState {
  final CashSessionCloseResult result;

  const CashSessionClosed(this.result);

  @override
  List<Object?> get props => [result];
}

/// Error state.
class CashSessionError extends CashSessionState {
  final String message;
  final String? code;

  const CashSessionError({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

// ============================================================================
// BLOC
// ============================================================================

class CashSessionBloc extends Bloc<CashSessionEvent, CashSessionState> {
  final CashSessionService _sessionService;
  final EventBus _eventBus;

  String? _currentSessionId;
  String? _currentUserId;

  CashSessionBloc({
    required CashSessionService sessionService,
    required EventBus eventBus,
  })  : _sessionService = sessionService,
        _eventBus = eventBus,
        super(CashSessionInitial()) {
    on<CashSessionCheckRequested>(_onCheckRequested);
    on<CashSessionOpenRequested>(_onOpenRequested);
    on<CashSessionIncomeRequested>(_onIncomeRequested);
    on<CashSessionWithdrawalRequested>(_onWithdrawalRequested);
    on<CashSessionExpenseRequested>(_onExpenseRequested);
    on<CashSessionCloseRequested>(_onCloseRequested);
    on<CashSessionRefreshRequested>(_onRefreshRequested);
  }

  /// Current active session ID (if any).
  String? get currentSessionId => _currentSessionId;

  Future<void> _onCheckRequested(
    CashSessionCheckRequested event,
    Emitter<CashSessionState> emit,
  ) async {
    emit(CashSessionLoading());
    try {
      _currentUserId = event.userId;
      final session = await _sessionService.getActiveSession(
        userId: event.userId,
      );

      if (session == null) {
        _currentSessionId = null;
        emit(CashSessionNone());
      } else {
        _currentSessionId = session.id;
        final summary = await _sessionService.getSessionSummary(
          sessionId: session.id,
        );
        emit(CashSessionActive(sessionId: session.id, summary: summary));
        _eventBus.fire(CashSessionOpenedEvent(session.id));
      }
    } on CashSessionException catch (e) {
      emit(CashSessionError(message: e.message, code: e.code));
    } catch (e) {
      emit(CashSessionError(message: e.toString()));
    }
  }

  Future<void> _onOpenRequested(
    CashSessionOpenRequested event,
    Emitter<CashSessionState> emit,
  ) async {
    emit(CashSessionLoading());
    try {
      final session = await _sessionService.openSession(
        tenantId: event.tenantId,
        cashRegisterId: event.cashRegisterId,
        userId: event.userId,
        initialAmount: event.initialAmount,
      );

      _currentSessionId = session.id;
      _currentUserId = event.userId;

      final summary = await _sessionService.getSessionSummary(
        sessionId: session.id,
      );

      emit(CashSessionActive(sessionId: session.id, summary: summary));
      _eventBus.fire(CashSessionOpenedEvent(session.id));
    } on CashSessionException catch (e) {
      emit(CashSessionError(message: e.message, code: e.code));
    } catch (e) {
      emit(CashSessionError(message: e.toString()));
    }
  }

  Future<void> _onIncomeRequested(
    CashSessionIncomeRequested event,
    Emitter<CashSessionState> emit,
  ) async {
    if (_currentSessionId == null) {
      emit(const CashSessionError(
        message: 'No active session',
        code: 'NO_SESSION',
      ));
      return;
    }

    try {
      await _sessionService.recordIncome(
        sessionId: _currentSessionId!,
        amount: event.amount,
        concept: event.concept,
        userId: event.userId,
        reference: event.reference,
      );

      // Refresh summary
      final summary = await _sessionService.getSessionSummary(
        sessionId: _currentSessionId!,
      );
      emit(CashSessionActive(sessionId: _currentSessionId!, summary: summary));
    } on CashSessionException catch (e) {
      emit(CashSessionError(message: e.message, code: e.code));
      if (_currentSessionId != null) {
        add(CashSessionRefreshRequested());
      }
    } catch (e) {
      emit(CashSessionError(message: e.toString()));
    }
  }

  Future<void> _onWithdrawalRequested(
    CashSessionWithdrawalRequested event,
    Emitter<CashSessionState> emit,
  ) async {
    if (_currentSessionId == null) {
      emit(const CashSessionError(
        message: 'No active session',
        code: 'NO_SESSION',
      ));
      return;
    }

    try {
      await _sessionService.recordWithdrawal(
        sessionId: _currentSessionId!,
        amount: event.amount,
        concept: event.concept,
        userId: event.userId,
        reference: event.reference,
      );

      // Refresh summary
      final summary = await _sessionService.getSessionSummary(
        sessionId: _currentSessionId!,
      );
      emit(CashSessionActive(sessionId: _currentSessionId!, summary: summary));
    } on CashSessionException catch (e) {
      emit(CashSessionError(message: e.message, code: e.code));
      // Restore active state
      if (_currentSessionId != null) {
        add(CashSessionRefreshRequested());
      }
    } catch (e) {
      emit(CashSessionError(message: e.toString()));
    }
  }

  Future<void> _onExpenseRequested(
    CashSessionExpenseRequested event,
    Emitter<CashSessionState> emit,
  ) async {
    if (_currentSessionId == null) {
      emit(const CashSessionError(
        message: 'No active session',
        code: 'NO_SESSION',
      ));
      return;
    }

    try {
      await _sessionService.recordExpense(
        sessionId: _currentSessionId!,
        amount: event.amount,
        concept: event.concept,
        userId: event.userId,
        category: event.category ?? CashMovementCategory.expense,
        reference: event.reference,
      );

      // Refresh summary
      final summary = await _sessionService.getSessionSummary(
        sessionId: _currentSessionId!,
      );
      emit(CashSessionActive(sessionId: _currentSessionId!, summary: summary));
    } on CashSessionException catch (e) {
      emit(CashSessionError(message: e.message, code: e.code));
      if (_currentSessionId != null) {
        add(CashSessionRefreshRequested());
      }
    } catch (e) {
      emit(CashSessionError(message: e.toString()));
    }
  }

  Future<void> _onCloseRequested(
    CashSessionCloseRequested event,
    Emitter<CashSessionState> emit,
  ) async {
    if (_currentSessionId == null) {
      emit(const CashSessionError(
        message: 'No active session to close',
        code: 'NO_SESSION',
      ));
      return;
    }

    emit(CashSessionLoading());
    try {
      final result = await _sessionService.closeSession(
        sessionId: _currentSessionId!,
        declaredAmount: event.declaredAmount,
        justification: event.justification,
      );

      _eventBus.fire(CashSessionClosedEvent(_currentSessionId!));
      _currentSessionId = null;

      emit(CashSessionClosed(result));
    } on CashSessionException catch (e) {
      emit(CashSessionError(message: e.message, code: e.code));
      // Don't clear session on error
    } catch (e) {
      emit(CashSessionError(message: e.toString()));
    }
  }

  Future<void> _onRefreshRequested(
    CashSessionRefreshRequested event,
    Emitter<CashSessionState> emit,
  ) async {
    if (_currentSessionId == null) {
      if (_currentUserId != null) {
        add(CashSessionCheckRequested(_currentUserId!));
      } else {
        emit(CashSessionNone());
      }
      return;
    }

    try {
      final summary = await _sessionService.getSessionSummary(
        sessionId: _currentSessionId!,
      );
      emit(CashSessionActive(sessionId: _currentSessionId!, summary: summary));
    } on CashSessionException catch (e) {
      emit(CashSessionError(message: e.message, code: e.code));
    } catch (e) {
      emit(CashSessionError(message: e.toString()));
    }
  }
}

// ============================================================================
// EVENTS (for EventBus)
// ============================================================================

class CashSessionOpenedEvent {
  final String sessionId;
  const CashSessionOpenedEvent(this.sessionId);
}

class CashSessionClosedEvent {
  final String sessionId;
  const CashSessionClosedEvent(this.sessionId);
}
