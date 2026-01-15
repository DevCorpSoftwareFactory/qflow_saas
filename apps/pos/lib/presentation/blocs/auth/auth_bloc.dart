import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../services/auth_service.dart';
import '../../../core/events.dart';
import 'package:event_bus/event_bus.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested(this.email, this.password);
}

class AuthLogoutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userId;
  final String branchId;
  final String tenantId;
  const AuthAuthenticated(this.userId, this.branchId, this.tenantId);
  @override
  List<Object> get props => [userId, branchId, tenantId];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
  @override
  List<Object> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final EventBus _eventBus;

  AuthBloc(this._authService, this._eventBus) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final context = await _authService.getContext();
    if (context['token'] != null) {
      // Restore session
      emit(
        AuthAuthenticated(
          context['userId'] ?? 'user',
          context['branchId'] ?? 'main',
          context['tenantId'] ?? 'default',
        ),
      );
      _eventBus.fire(const AuthStateChangedEvent(true));
    } else {
      emit(AuthUnauthenticated());
      _eventBus.fire(const AuthStateChangedEvent(false));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userId = await _authService.login(event.email, event.password);
      final context = await _authService.getContext();
      emit(
        AuthAuthenticated(
          userId,
          context['branchId'] ?? 'main',
          context['tenantId'] ?? 'default',
        ),
      );
      _eventBus.fire(const AuthStateChangedEvent(true));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _authService.logout();
    emit(AuthUnauthenticated());
    _eventBus.fire(const AuthStateChangedEvent(false));
  }
}
