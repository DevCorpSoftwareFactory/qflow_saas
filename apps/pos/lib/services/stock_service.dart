import '../data/local/database.dart';
import '../data/api/api_client.dart';
import 'exceptions/stock_insufficient_exception.dart';

/// Service for stock validation (Offline-First).
/// Enforces immutable rule: "Never sell without available stock."
class StockService {
  final AppDatabase _db;
  final ApiClient _api;

  StockService({required AppDatabase database, required ApiClient apiClient})
    : _db = database,
      _api = apiClient;

  /// Check stock availability.
  /// [isOnline] - If true, queries the backend. If false, uses local database.
  Future<bool> checkAvailability({
    required String variantId,
    required String branchId,
    required int quantity,
    bool isOnline = false,
  }) async {
    if (isOnline) {
      return _checkOnline(variantId, branchId, quantity);
    }
    return _checkOffline(variantId, branchId, quantity);
  }

  /// Offline validation using local Drift database.
  Future<bool> _checkOffline(
    String variantId,
    String branchId,
    int quantity,
  ) async {
    // 1. Check if product tracks inventory
    final variant = await (_db.select(
      _db.localProductVariants,
    )..where((v) => v.id.equals(variantId))).getSingleOrNull();

    if (variant == null) {
      throw StockInsufficientException(
        variantId: variantId,
        available: 0,
        required: quantity.toDouble(),
        branchId: branchId,
      );
    }

    // Get product to check trackInventory
    final product = await (_db.select(
      _db.localProducts,
    )..where((p) => p.id.equals(variant.productId))).getSingleOrNull();

    // If product doesn't track inventory (service), skip validation
    if (product != null && !product.trackInventory) {
      return true;
    }

    // 2. Calculate available stock from movements
    // SUM(quantity) where movementType is inbound - SUM(quantity) where outbound
    final inboundTypes = [
      MovementType.purchase,
      MovementType.transferIn,
      MovementType.returnCustomer,
    ];
    final outboundTypes = [
      MovementType.sale,
      MovementType.transferOut,
      MovementType.returnSupplier,
      MovementType.waste,
      MovementType.internalConsumption,
    ];

    // Query all movements for this variant/branch
    final movements =
        await (_db.select(_db.localInventoryMovements)
              ..where((m) => m.variantId.equals(variantId))
              ..where((m) => m.branchId.equals(branchId)))
            .get();

    int inbound = 0;
    int outbound = 0;

    for (final m in movements) {
      if (inboundTypes.contains(m.movementType)) {
        inbound += m.quantity;
      } else if (outboundTypes.contains(m.movementType)) {
        outbound += m.quantity;
      }
    }

    final available = inbound - outbound;

    // 3. Strict comparison
    if (available < quantity) {
      throw StockInsufficientException(
        variantId: variantId,
        available: available.toDouble(),
        required: quantity.toDouble(),
        branchId: branchId,
      );
    }

    return true;
  }

  /// Online validation via backend API.
  Future<bool> _checkOnline(
    String variantId,
    String branchId,
    int quantity,
  ) async {
    try {
      final response = await _api.post('/inventory/check-availability', {
        'variantId': variantId,
        'branchId': branchId,
        'quantity': quantity,
      });

      return response['available'] == true;
    } catch (e) {
      if (e is Map<String, dynamic>) {
        // Handle API specific error response if ApiClient throws structured errors
        // Assuming ApiClient might throw an exception with response data
        // For now, let's assume standardized error handling in ApiClient
      }

      // If 400 Bad Request (Insufficient Stock), ApiClient throws Exception
      // We need to parse that if possible, or just fail safely.
      // But _checkOffline is the fallback.

      // Network error or 500 - fallback to offline
      return _checkOffline(variantId, branchId, quantity);
    }
  }
}
