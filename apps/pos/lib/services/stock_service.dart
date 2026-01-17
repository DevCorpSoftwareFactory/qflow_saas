import '../data/local/database.dart';
import '../data/api/api_client.dart';
import 'exceptions/stock_insufficient_exception.dart';
import 'fifo_service.dart';
import 'stock_reservation_service.dart';

/// Service for stock validation (Offline-First).
/// Enforces immutable rule: "Never sell without available stock."
///
/// Improved version that:
/// - Validates against actual lot quantities (not just movements)
/// - Considers expiry dates (excludes expired lots)
/// - Calculates reserved stock from pending orders
/// - Provides detailed availability information
class StockService {
  final AppDatabase _db;
  final ApiClient _api;
  final FifoService _fifoService;
  final StockReservationService _reservationService;

  StockService({
    required AppDatabase database,
    required ApiClient apiClient,
    required FifoService fifoService,
    required StockReservationService reservationService,
  })  : _db = database,
        _api = apiClient,
        _fifoService = fifoService,
        _reservationService = reservationService;

  /// Check stock availability.
  /// [isOnline] - If true, queries the backend. If false, uses local database.
  ///
  /// Returns true if stock is available, throws [StockInsufficientException] otherwise.
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

  /// Get detailed availability info for a variant.
  Future<StockAvailability> getAvailability({
    required String variantId,
    required String branchId,
  }) async {
    // Check if product tracks inventory
    final variant = await (_db.select(_db.localProductVariants)
          ..where((v) => v.id.equals(variantId)))
        .getSingleOrNull();

    if (variant == null) {
      return const StockAvailability(
        available: 0,
        reserved: 0,
        expiringWithin15Days: 0,
        expiredNotDisposed: 0,
        tracksInventory: false,
      );
    }

    // Get product to check trackInventory
    final product = await (_db.select(_db.localProducts)
          ..where((p) => p.id.equals(variant.productId)))
        .getSingleOrNull();

    if (product != null && !product.trackInventory) {
      return StockAvailability(
        available: double.infinity.toInt(),
        reserved: 0,
        expiringWithin15Days: 0,
        expiredNotDisposed: 0,
        tracksInventory: false,
      );
    }

    // Get available lots from FIFO service
    final available = await _fifoService.getTotalAvailableStock(
      variantId: variantId,
      branchId: branchId,
    );

    // Get expiring lots
    final expiringLots = await _fifoService.getExpiringLots(
      branchId: branchId,
      daysThreshold: 15,
    );
    int expiringQuantity = 0;
    for (final lot in expiringLots) {
      if (lot.variantId == variantId) {
        expiringQuantity += lot.currentQuantity;
      }
    }

    // Get expired lots
    final expiredLots = await _fifoService.getExpiredLots(branchId: branchId);
    int expiredQuantity = 0;
    for (final lot in expiredLots) {
      if (lot.variantId == variantId) {
        expiredQuantity += lot.currentQuantity;
      }
    }

    // Calculate reserved stock from pending orders
    final reserved = await _reservationService.getReservedQuantity(
      variantId: variantId,
      branchId: branchId,
    );

    return StockAvailability(
      available: available,
      reserved: reserved,
      expiringWithin15Days: expiringQuantity,
      expiredNotDisposed: expiredQuantity,
      tracksInventory: true,
    );
  }

  /// Offline validation using local Drift database with FIFO service.
  Future<bool> _checkOffline(
    String variantId,
    String branchId,
    int quantity,
  ) async {
    // 1. Check if variant exists
    final variant = await (_db.select(_db.localProductVariants)
          ..where((v) => v.id.equals(variantId)))
        .getSingleOrNull();

    if (variant == null) {
      throw StockInsufficientException(
        variantId: variantId,
        available: 0,
        required: quantity.toDouble(),
        branchId: branchId,
        reason: 'Variant not found',
      );
    }

    // 2. Get product to check trackInventory
    final product = await (_db.select(_db.localProducts)
          ..where((p) => p.id.equals(variant.productId)))
        .getSingleOrNull();

    // If product doesn't track inventory (service), skip validation
    if (product != null && !product.trackInventory) {
      return true;
    }

    // 3. Use FIFO service for accurate lot-based availability
    final available = await _fifoService.getTotalAvailableStock(
      variantId: variantId,
      branchId: branchId,
    );

    // 4. Strict comparison
    if (available < quantity) {
      throw StockInsufficientException(
        variantId: variantId,
        available: available.toDouble(),
        required: quantity.toDouble(),
        branchId: branchId,
        reason: available == 0
            ? 'No stock available'
            : 'Insufficient stock (need $quantity, have $available)',
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

      if (response['available'] == true) {
        return true;
      }

      // API returned insufficient stock
      throw StockInsufficientException(
        variantId: variantId,
        available: (response['availableQuantity'] ?? 0).toDouble(),
        required: quantity.toDouble(),
        branchId: branchId,
        reason: response['reason'] ?? 'Insufficient stock',
      );
    } catch (e) {
      if (e is StockInsufficientException) {
        rethrow;
      }

      // Network error or 500 - fallback to offline
      return _checkOffline(variantId, branchId, quantity);
    }
  }

  /// Validate stock for multiple items at once.
  /// Used before processing a sale to validate all items.
  Future<Map<String, bool>> validateMultipleItems({
    required List<StockValidationItem> items,
    required String branchId,
    bool isOnline = false,
  }) async {
    final results = <String, bool>{};

    for (final item in items) {
      try {
        await checkAvailability(
          variantId: item.variantId,
          branchId: branchId,
          quantity: item.quantity,
          isOnline: isOnline,
        );
        results[item.variantId] = true;
      } on StockInsufficientException {
        results[item.variantId] = false;
      }
    }

    return results;
  }

  /// Get all items that fail stock validation.
  Future<List<StockValidationFailure>> getValidationFailures({
    required List<StockValidationItem> items,
    required String branchId,
  }) async {
    final failures = <StockValidationFailure>[];

    for (final item in items) {
      try {
        await checkAvailability(
          variantId: item.variantId,
          branchId: branchId,
          quantity: item.quantity,
          isOnline: false,
        );
      } on StockInsufficientException catch (e) {
        failures.add(StockValidationFailure(
          variantId: item.variantId,
          requestedQuantity: item.quantity,
          availableQuantity: e.available.toInt(),
          reason: e.reason ?? 'Insufficient stock',
        ));
      }
    }

    return failures;
  }
}

/// Detailed stock availability information.
class StockAvailability {
  final int available;
  final int reserved;
  final int expiringWithin15Days;
  final int expiredNotDisposed;
  final bool tracksInventory;

  const StockAvailability({
    required this.available,
    required this.reserved,
    required this.expiringWithin15Days,
    required this.expiredNotDisposed,
    required this.tracksInventory,
  });

  /// Net available stock (available - reserved)
  int get netAvailable => available - reserved;

  /// Stock that is available but expiring soon
  bool get hasExpiringStock => expiringWithin15Days > 0;

  /// Stock that has expired but not been disposed
  bool get hasExpiredStock => expiredNotDisposed > 0;
}

/// Item for stock validation.
class StockValidationItem {
  final String variantId;
  final int quantity;

  const StockValidationItem({
    required this.variantId,
    required this.quantity,
  });
}

/// Result of a failed stock validation.
class StockValidationFailure {
  final String variantId;
  final int requestedQuantity;
  final int availableQuantity;
  final String reason;

  const StockValidationFailure({
    required this.variantId,
    required this.requestedQuantity,
    required this.availableQuantity,
    required this.reason,
  });

  int get deficit => requestedQuantity - availableQuantity;
}
