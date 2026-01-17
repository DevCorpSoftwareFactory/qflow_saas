import 'package:bloc_test/bloc_test.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pos/presentation/blocs/auth/auth_bloc.dart';
import 'package:pos/services/auth_service.dart';

@GenerateNiceMocks([MockSpec<AuthService>(), MockSpec<EventBus>()])
import 'auth_bloc_test.mocks.dart';

void main() {
  group('AuthBloc', () {
    late MockAuthService mockAuthService;
    late MockEventBus mockEventBus;
    late AuthBloc authBloc;

    setUp(() {
      mockAuthService = MockAuthService();
      mockEventBus = MockEventBus();
      authBloc = AuthBloc(mockAuthService, mockEventBus);
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state is AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    group('AuthForgotPasswordRequested', () {
      const email = 'test@example.com';

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthPasswordResetEmailSent] when forgotPassword succeeds',
        build: () {
          when(mockAuthService.forgotPassword(email)).thenAnswer((_) async {});
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthForgotPasswordRequested(email)),
        expect: () => [
          AuthLoading(),
          AuthPasswordResetEmailSent(),
        ],
        verify: (_) {
          verify(mockAuthService.forgotPassword(email)).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when forgotPassword fails',
        build: () {
          when(mockAuthService.forgotPassword(email))
              .thenThrow(Exception('Network error'));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthForgotPasswordRequested(email)),
        expect: () => [
          AuthLoading(),
          const AuthFailure('Exception: Network error'),
        ],
        verify: (_) {
          verify(mockAuthService.forgotPassword(email)).called(1);
        },
      );
    });
  });
}
