import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/presentation/blocs/auth/auth_bloc.dart';
import 'package:pos/presentation/screens/auth/forgot_password_screen.dart';
import 'package:go_router/go_router.dart';

// Mock AuthBloc using mocktail
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

// Define a Fake for AuthEvent to use with registerFallbackValue
class FakeAuthEvent extends Fake implements AuthEvent {}

// Define a Fake for AuthState
class FakeAuthState extends Fake implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  group('ForgotPasswordScreen', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      // Setup default behavior
      when(() => mockAuthBloc.state).thenReturn(AuthInitial());
      when(() => mockAuthBloc.stream)
          .thenAnswer((_) => Stream.value(AuthInitial()));
    });

    Widget createWidgetUnderTest() {
      final router = GoRouter(
        initialLocation: '/forgot-password',
        routes: [
          GoRoute(
            path: '/forgot-password',
            builder: (context, state) => BlocProvider<AuthBloc>.value(
              value: mockAuthBloc,
              child: const ForgotPasswordScreen(),
            ),
          ),
          GoRoute(path: '/login', builder: (_, __) => const SizedBox()),
        ],
      );

      return MaterialApp.router(
        routerConfig: router,
      );
    }

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Send Reset Link'), findsOneWidget);
    });

    testWidgets('shows validation error when email is empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
      verifyNever(() => mockAuthBloc.add(any()));
    });

    testWidgets('shows validation error when email is invalid', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextFormField), 'invalid-email');
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      expect(find.text('Please enter a valid email'), findsOneWidget);
      verifyNever(() => mockAuthBloc.add(any()));
    });

    testWidgets('submits form when email is valid', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      const email = 'test@example.com';
      await tester.enterText(find.byType(TextFormField), email);
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      verify(() => mockAuthBloc.add(const AuthForgotPasswordRequested(email)))
          .called(1);
    });

    testWidgets('shows loading indicator when state is AuthLoading',
        (tester) async {
      when(() => mockAuthBloc.state).thenReturn(AuthLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Send Reset Link'), findsNothing);
    });

    testWidgets('shows error snackbar when AuthFailure occurs', (tester) async {
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([const AuthFailure('Error message')]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // trigger listener

      expect(find.text('Error message'), findsOneWidget);
    });

    testWidgets(
        'shows success snackbar and pops when AuthPasswordResetEmailSent occurs',
        (tester) async {
      // Use controller for precise event timing
      final controller = StreamController<AuthState>();
      addTearDown(() => controller.close());

      whenListen(
        mockAuthBloc,
        controller.stream,
        initialState: AuthInitial(),
      );

      // Custom router setup with nested routes to ensure valid history stack for pop
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: TextButton(
                onPressed: () => context.push('/forgot'),
                child: const Text('Go to Forgot Password'),
              ),
            ),
            routes: [
              GoRoute(
                path: 'forgot',
                builder: (context, state) => BlocProvider<AuthBloc>.value(
                  value: mockAuthBloc,
                  child: const ForgotPasswordScreen(),
                ),
              ),
            ],
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Navigate to Forgot Password screen
      await tester.tap(find.text('Go to Forgot Password'));
      await tester.pumpAndSettle();

      // Verify we are on the screen
      expect(find.text('Reset Password'), findsOneWidget);

      // Emit success state
      controller.add(AuthPasswordResetEmailSent());
      await tester.pump(); // Trigger listener
      await tester.pumpAndSettle(); // Resolve SnackBar animation and Pop

      // Verify SnackBar
      expect(find.text('Instructions sent! Check your email.'), findsOneWidget);

      // Verify we popped back to Home
      expect(find.text('Go to Forgot Password'), findsOneWidget);
      expect(find.text('Reset Password'), findsNothing);
    });
  });
}
