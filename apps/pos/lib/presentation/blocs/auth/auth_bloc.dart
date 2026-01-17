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

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;
  const AuthForgotPasswordRequested(this.email);
}

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
  final String userName;
  final String branchName;
  final String tenantName;

  const AuthAuthenticated(
    this.userId,
    this.branchId,
    this.tenantId,
    this.userName,
    this.branchName,
    this.tenantName,
  );

  @override
  List<Object> get props => [
        userId,
        branchId,
        tenantId,
        userName,
        branchName,
        tenantName,
      ];
}

class AuthUnauthenticated extends AuthState {}

class AuthPasswordResetEmailSent extends AuthState {}

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
    on<AuthForgotPasswordRequested>(_onForgotPasswordRequested);
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
          context['userName'] ?? 'User',
          context['branchName'] ?? 'Branch',
          context['tenantName'] ?? 'Tenant',
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
          context['userName'] ?? 'User',
          context['branchName'] ?? 'Branch',
          context['tenantName'] ?? 'Tenant',
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

  Future<void> _onForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.forgotPassword(event.email);
      emit(AuthPasswordResetEmailSent());
      // Reset state to unauthenticated after success so user can login?
      // Or let the UI handle it. UI will likely pop the screen on success.
      // But we should probably revert to AuthUnauthenticated quickly or just let it be.
      // Ideally, after showing success msg, we want to be back in "Unauthenticated" state effectively.
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
