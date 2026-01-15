import 'package:get_it/get_it.dart';
import 'package:event_bus/event_bus.dart';
import '../core/config.dart';

// Actually EventBus from package is fine, but we might want a global instance.
// Let's use the package directly via GetIt.

import '../data/local/database.dart';
import '../data/api/api_client.dart';
import '../services/auth_service.dart';
import '../services/catalog_service.dart';
import '../services/stock_service.dart';
import '../services/sales_service.dart';
import '../data/sync/sync_service.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  // 1. Core
  getIt.registerSingleton<EventBus>(EventBus());

  // 2. Data Sources
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  getIt.registerSingleton<ApiClient>(ApiClient(baseUrl: AppConfig.apiBaseUrl));

  // 3. Services
  getIt.registerFactory<AuthService>(() => AuthService(getIt<ApiClient>()));

  getIt.registerFactory<CatalogService>(
    () => CatalogService(getIt<AppDatabase>(), getIt<ApiClient>()),
  );

  getIt.registerFactory<StockService>(
    () => StockService(
      database: getIt<AppDatabase>(),
      apiClient: getIt<ApiClient>(),
    ),
  );

  getIt.registerFactory<SalesService>(
    () => SalesService(
      database: getIt<AppDatabase>(),
      stockService: getIt<StockService>(),
    ),
  );

  getIt.registerFactory<SyncService>(
    () => SyncService(getIt<AppDatabase>(), getIt<ApiClient>()),
  );
}
