import '../data/api/api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  /// Helper to check authentication status
  Future<bool> isAuthenticated() async {
    final token = await _apiClient.getToken();
    return token != null;
  }

  /// Login with email and password
  /// Returns user ID
  Future<String> login(String email, String password) async {
    try {
      final response = await _apiClient.post('/auth/login', {
        'email': email,
        'password': password,
      });

      final data = response as Map<String, dynamic>;
      final token = data['token'] as String;
      final userId = data['userId'] as String;
      final tenantId = data['tenantId'] as String;
      // Use provided branchId or default to 'main' if not present in MVP API
      final branchId = (data['branchId'] as String?) ?? 'main';

      await _apiClient.saveAuth(token, tenantId, branchId, userId);

      return userId;
    } catch (e) {
      // If login fails, ensure partial data is cleared
      await _apiClient.clearAuth();
      rethrow;
    }
  }

  /// Logout and clear storage
  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout', {});
    } catch (e) {
      // Ignore errors on logout (e.g. if token already expired)
    } finally {
      await _apiClient.clearAuth();
    }
  }

  /// Get current user context
  Future<Map<String, String?>> getContext() async {
    return {
      'token': await _apiClient.getToken(),
      'tenantId': await _apiClient.getTenantId(),
      'branchId': await _apiClient.getBranchId(),
      'userId': await _apiClient.getUserId(),
    };
  }
}
