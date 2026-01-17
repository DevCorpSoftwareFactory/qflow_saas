import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../../services/secure_storage_service.dart';

class ApiClient {
  final String baseUrl;
  final http.Client _client;
  final SecureStorageService _secureStorage;

  // Hive box for storing non-sensitive session data
  static const String _authBoxName = 'auth_box';
  static const String _tenantKey = 'tenant_id';
  static const String _branchKey = 'branch_id';
  static const String _userIdKey = 'user_id';
  static const String _tenantNameKey = 'tenant_name';
  static const String _branchNameKey = 'branch_name';
  static const String _userNameKey = 'user_name';

  ApiClient({
    required this.baseUrl,
    http.Client? client,
    SecureStorageService? secureStorage,
  })  : _client = client ?? http.Client(),
        _secureStorage = secureStorage ?? SecureStorageService();

  /// Get current JWT token
  Future<String?> getToken() async {
    return _secureStorage.getAccessToken();
  }

  /// Get current Tenant ID
  Future<String?> getTenantId() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_tenantKey);
  }

  /// Get current Branch ID
  Future<String?> getBranchId() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_branchKey);
  }

  /// Get current User ID
  Future<String?> getUserId() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_userIdKey);
  }

  Future<String?> getTenantName() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_tenantNameKey);
  }

  Future<String?> getBranchName() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_branchNameKey);
  }

  Future<String?> getUserName() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_userNameKey);
  }

  /// Save auth data
  Future<void> saveAuth(
    String token,
    String tenantId,
    String branchId,
    String userId, {
    String? refreshToken,
    String? tenantName,
    String? branchName,
    String? userName,
  }) async {
    // Save tokens securely
    await _secureStorage.saveTokens(
      accessToken: token,
      refreshToken: refreshToken,
    );

    // Save context to Hive
    final box = await Hive.openBox(_authBoxName);
    await box.put(_tenantKey, tenantId);
    await box.put(_branchKey, branchId);
    await box.put(_userIdKey, userId);
    if (tenantName != null) await box.put(_tenantNameKey, tenantName);
    if (branchName != null) await box.put(_branchNameKey, branchName);
    if (userName != null) await box.put(_userNameKey, userName);
  }

  /// Clear auth data
  Future<void> clearAuth() async {
    await _secureStorage.clearTokens();

    final box = await Hive.openBox(_authBoxName);
    await box.delete(_tenantKey);
    await box.delete(_branchKey);
    await box.delete(_userIdKey);
    await box.delete(_tenantNameKey);
    await box.delete(_branchNameKey);
    await box.delete(_userNameKey);
  }

  /// Helper to get headers
  Future<Map<String, String>> _getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Attempt to refresh the token
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null) return false;

      // prevent infinite loop by calling client directly
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['accessToken'];
        final newRefreshToken = data['refreshToken'];

        if (newAccessToken != null) {
          await _secureStorage.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );
          return true;
        }
      }
    } catch (e) {
      // Refresh failed
    }

    // If refresh failed, clear everything
    await clearAuth();
    return false;
  }

  Future<dynamic> _invokeWithRetry(
    Future<http.Response> Function() requestFn,
  ) async {
    var response = await requestFn();

    if (response.statusCode == 401) {
      // Try refresh
      final refreshSuccess = await _refreshToken();
      if (refreshSuccess) {
        // Retry request
        response = await requestFn();
      }
    }

    return _handleResponse(response);
  }

  /// GET request
  Future<dynamic> get(String endpoint) async {
    return _invokeWithRetry(() async => _client.get(
          Uri.parse('$baseUrl$endpoint'),
          headers: await _getHeaders(),
        ));
  }

  /// POST request
  Future<dynamic> post(String endpoint, dynamic data) async {
    // Special case: login shouldn't retry with refresh token
    if (endpoint == '/auth/login') {
      final response = await _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _getHeaders(),
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    }

    return _invokeWithRetry(() async => _client.post(
          Uri.parse('$baseUrl$endpoint'),
          headers: await _getHeaders(),
          body: jsonEncode(data),
        ));
  }

  /// PUT request
  Future<dynamic> put(String endpoint, dynamic data) async {
    return _invokeWithRetry(() async => _client.put(
          Uri.parse('$baseUrl$endpoint'),
          headers: await _getHeaders(),
          body: jsonEncode(data),
        ));
  }

  /// Handle API response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException: $statusCode - $message';
}
