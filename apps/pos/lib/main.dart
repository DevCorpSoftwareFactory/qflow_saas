import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'di/injection.dart';
import 'presentation/router/app_router.dart';
import 'presentation/blocs/app/app_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/catalog/catalog_bloc.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'services/auth_service.dart';
import 'services/catalog_service.dart';
import 'services/sales_service.dart';
import 'services/hardware/hardware_service.dart';
import 'services/hardware/receipt_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await configureInjection();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthBloc _authBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(getIt<AuthService>(), getIt<EventBus>())
      ..add(AuthCheckRequested());
    _appRouter = AppRouter(_authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()),
        BlocProvider.value(value: _authBloc),
        BlocProvider(
          create: (context) =>
              CatalogBloc(getIt<CatalogService>(), getIt<EventBus>()),
        ),
        BlocProvider(
          create: (context) => CartBloc(
            getIt<SalesService>(),
            getIt<HardwareService>(),
            getIt<ReceiptGenerator>(),
          ),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'QFlow POS',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: state.themeMode,
            routerConfig: _appRouter.router,
          );
        },
      ),
    );
  }
}
