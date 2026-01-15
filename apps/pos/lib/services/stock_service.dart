import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/local/database.dart';
import 'exceptions/stock_insufficient_exception.dart';

/// Service for stock validation (Offline-First).
/// Enforces immutable rule: "Never sell without available stock."
class StockService {
  final AppDatabase _db;
  final String _apiBaseUrl;

  StockService({
    required AppDatabase database,
    String? apiBaseUrl,
  })  : _db = database,
        _apiBaseUrl = apiBaseUrl ?? 'http://localhost:3000';

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
    final variant = await (_db.select(_db.localProductVariants)
          ..where((v) => v.id.equals(variantId)))
        .getSingleOrNull();

    if (variant == null) {
      throw StockInsufficientException(
        variantId: variantId,
        available: 0,
        required: quantity.toDouble(),
        branchId: branchId,
      );
    }

    // Get product to check trackInventory
    final product = await (_db.select(_db.localProducts)
          ..where((p) => p.id.equals(variant.productId)))
        .getSingleOrNull();

    // If product doesn't track inventory (service), skip validation
    if (product != null && !product.trackInventory) {
      return true;
    }

    // 2. Calculate available stock from movements
    // SUM(quantity) where movementType is inbound - SUM(quantity) where outbound
    final inboundTypes = [
      MovementType.purchase,
      MovementType.transfer_in,
      MovementType.return_customer,
    ];
    final outboundTypes = [
      MovementType.sale,
      MovementType.transfer_out,
      MovementType.return_supplier,
      MovementType.waste,
      MovementType.internal_consumption,
    ];

    // Query all movements for this variant/branch
    final movements = await (_db.select(_db.localInventoryMovements)
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
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/inventory/check-availability'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'variantId': variantId,
          'branchId': branchId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data['available'] == true;
      } else {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        final details = errorData['details'] as Map<String, dynamic>?;

        throw StockInsufficientException(
          variantId: details?['variantId'] ?? variantId,
          available: (details?['available'] ?? 0).toDouble(),
          required: (details?['required'] ?? quantity).toDouble(),
          branchId: details?['warehouseId'] ?? branchId,
        );
      }
    } catch (e) {
      if (e is StockInsufficientException) rethrow;
      // Network error - fallback to offline
      return _checkOffline(variantId, branchId, quantity);
    }
  }
}
