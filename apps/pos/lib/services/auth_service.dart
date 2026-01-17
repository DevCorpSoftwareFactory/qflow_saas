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
      final token = data['accessToken'] as String; // Correct key
      final refreshToken = data['refreshToken'] as String?; // New key
      final userData = data['user'] as Map<String, dynamic>;

      final userId = userData['id'] as String;
      final tenantId = userData['tenantId'] as String;
      // Use provided branchId or default to 'main' if not present in MVP API
      final branchId = (data['branchId'] as String?) ?? 'main';

      // Mock/Extract names for MVP details
      // Ideally these come from API
      final tenantName = (data['tenantName'] as String?) ?? 'QFlow Tenant';
      final branchName = (data['branchName'] as String?) ?? 'Main Branch';
      final userName = (userData['fullName'] as String?) ?? email.split('@')[0];

      await _apiClient.saveAuth(
        token,
        tenantId,
        branchId,
        userId,
        refreshToken: refreshToken,
        tenantName: tenantName,
        branchName: branchName,
        userName: userName,
      );

      return userId;
    } catch (e) {
      // If login fails, ensure partial data is cleared
      await _apiClient.clearAuth();
      rethrow;
    }
  }

  /// Request password reset
  Future<void> forgotPassword(String email) async {
    await _apiClient.post('/auth/forgot-password', {'email': email});
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
      'tenantName': await _apiClient.getTenantName(),
      'branchName': await _apiClient.getBranchName(),
      'userName': await _apiClient.getUserName(),
    };
  }
}
