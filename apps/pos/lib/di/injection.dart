import 'package:get_it/get_it.dart';
import 'package:event_bus/event_bus.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/config.dart';
import '../data/local/database.dart';
import '../data/api/api_client.dart';
import '../services/auth_service.dart';
import '../services/catalog_service.dart';
import '../services/stock_service.dart';
import '../services/sales_service.dart';
import '../services/fifo_service.dart';
import '../services/cash_session_service.dart';
import '../services/stock_reservation_service.dart';
import '../data/sync/sync_service.dart';
import '../services/hardware/hardware_service.dart';
import '../services/hardware/receipt_generator.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  // 0. Initialize Hive for Flutter (required before opening boxes)
  await Hive.initFlutter();

  // 1. Core Infrastructure
  getIt.registerSingleton<EventBus>(EventBus());

  // 2. Data Sources
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerSingleton<ApiClient>(ApiClient(baseUrl: AppConfig.apiBaseUrl));

  // 3. Base Services (no dependencies on other services)
  getIt.registerLazySingleton<SyncService>(
    () => SyncService(getIt<AppDatabase>(), getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<FifoService>(
    () => FifoService(database: getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<StockReservationService>(
    () => StockReservationService(database: getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<CashSessionService>(
    () => CashSessionService(
      database: getIt<AppDatabase>(),
      syncService: getIt<SyncService>(),
    ),
  );

  getIt.registerLazySingleton<HardwareService>(() => HardwareService());
  getIt.registerLazySingleton<ReceiptGenerator>(() => ReceiptGenerator());

  // 4. Services with Dependencies
  getIt.registerFactory<AuthService>(() => AuthService(getIt<ApiClient>()));

  getIt.registerFactory<CatalogService>(
    () => CatalogService(getIt<AppDatabase>(), getIt<ApiClient>()),
  );

  getIt.registerFactory<StockService>(
    () => StockService(
      database: getIt<AppDatabase>(),
      apiClient: getIt<ApiClient>(),
      fifoService: getIt<FifoService>(),
      reservationService: getIt<StockReservationService>(),
    ),
  );

  getIt.registerFactory<SalesService>(
    () => SalesService(
      database: getIt<AppDatabase>(),
      stockService: getIt<StockService>(),
      fifoService: getIt<FifoService>(),
      cashSessionService: getIt<CashSessionService>(),
    ),
  );
}
