import 'dart:convert';
import 'package:http/http.dart' as http;

/// API client for communicating with the PostgreSQL backend.
/// Used by the sync service to push local changes to the server.
class ApiClient {
  final String baseUrl;
  final http.Client _httpClient;
  String? _tenantId;
  String? _accessToken;

  ApiClient({
    required this.baseUrl,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Set the current tenant context for API calls
  void setTenantContext(String tenantId) {
    _tenantId = tenantId;
  }

  /// Set the access token for authenticated requests
  void setAccessToken(String token) {
    _accessToken = token;
  }

  /// Get common headers for API requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_tenantId != null) 'X-Tenant-ID': _tenantId!,
    if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
  };

  /// Test connection to the PostgreSQL backend
  Future<ConnectionTestResult> testConnection() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/api/health'),
        headers: _headers,
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ConnectionTestResult(
          success: true,
          message: 'Connected to PostgreSQL backend',
          serverVersion: data['version'] ?? 'unknown',
          tableCount: data['tableCount'] ?? 0,
        );
      } else {
        return ConnectionTestResult(
          success: false,
          message: 'Server returned status ${response.statusCode}',
        );
      }
    } catch (e) {
      return ConnectionTestResult(
        success: false,
        message: 'Connection failed: $e',
      );
    }
  }

  /// Sync a sale to the PostgreSQL backend
  Future<SyncResponse> syncSale(Map<String, dynamic> saleData) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$baseUrl/api/sales'),
        headers: _headers,
        body: jsonEncode(saleData),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SyncResponse(
          success: true,
          serverId: data['id'],
          serverNumber: data['saleNumber'],
        );
      } else {
        return SyncResponse(
          success: false,
          error: 'Server returned status ${response.statusCode}',
        );
      }
    } catch (e) {
      return SyncResponse(
        success: false,
        error: e.toString(),
      );
    }
  }

  /// Fetch products from the server for local cache
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/api/products'),
        headers: _headers,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Fetch price lists from the server
  Future<List<Map<String, dynamic>>> fetchPriceLists() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/api/price-lists'),
        headers: _headers,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  void dispose() {
    _httpClient.close();
  }
}

/// Result of a connection test
class ConnectionTestResult {
  final bool success;
  final String message;
  final String? serverVersion;
  final int? tableCount;

  ConnectionTestResult({
    required this.success,
    required this.message,
    this.serverVersion,
    this.tableCount,
  });
}

/// Result of a sync operation
class SyncResponse {
  final bool success;
  final String? serverId;
  final String? serverNumber;
  final String? error;

  SyncResponse({
    required this.success,
    this.serverId,
    this.serverNumber,
    this.error,
  });
}
