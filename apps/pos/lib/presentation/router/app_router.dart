import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../../core/utils/go_router_refresh_stream.dart';
import '../screens/login_screen.dart';
import '../screens/pos_screen.dart';
import '../screens/catalog/product_detail_screen.dart';
import '../screens/cash_session/close_session_screen.dart';
import '../screens/cash_session/cash_session_report_screen.dart';
import '../screens/auth/forgot_password_screen.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/pos', // Default to protected, let redirect handle it
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final isLoggedIn = authBloc.state is AuthAuthenticated;
      final isLoggingIn = state.uri.toString() == '/login';

      if (!isLoggedIn) {
        // If not logged in and not on login page, go to login
        return isLoggingIn ? null : '/login';
      }

      // If logged in and on login page, go to pos
      if (isLoggingIn) {
        return '/pos';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/pos',
        builder: (context, state) => const PosScreen(),
        routes: [
          GoRoute(
            path: 'product/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ProductDetailScreen(variantId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/cash-session/close',
        builder: (context, state) => const CloseSessionScreen(),
      ),
      GoRoute(
        path: '/cash-session/report/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CashSessionReportScreen(sessionId: id);
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  );
}
