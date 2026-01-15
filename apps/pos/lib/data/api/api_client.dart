import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  // Hive box for storing auth token
  static const String _authBoxName = 'auth_box';
  static const String _tokenKey = 'jwt_token';
  static const String _tenantKey = 'tenant_id';
  static const String _branchKey = 'branch_id';
  static const String _userIdKey = 'user_id';

  ApiClient({required this.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  /// Get current JWT token
  Future<String?> getToken() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_tokenKey);
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

  /// Save auth data
  Future<void> saveAuth(
    String token,
    String tenantId,
    String branchId,
    String userId,
  ) async {
    final box = await Hive.openBox(_authBoxName);
    await box.put(_tokenKey, token);
    await box.put(_tenantKey, tenantId);
    await box.put(_branchKey, branchId);
    await box.put(_userIdKey, userId);
  }

  /// Clear auth data
  Future<void> clearAuth() async {
    final box = await Hive.openBox(_authBoxName);
    await box.delete(_tokenKey);
    await box.delete(_tenantKey);
    await box.delete(_branchKey);
    await box.delete(_userIdKey);
  }

  /// Helper to get headers
  Future<Map<String, String>> _getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// GET request
  Future<dynamic> get(String endpoint) async {
    final response = await _client.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _getHeaders(),
    );
    return _handleResponse(response);
  }

  /// POST request
  Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await _client.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// PUT request
  Future<dynamic> put(String endpoint, dynamic data) async {
    final response = await _client.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
    return _handleResponse(response);
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
