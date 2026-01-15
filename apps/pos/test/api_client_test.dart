import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

import 'package:pos/data/remote/api_client.dart';

void main() {
  group('API Client - PostgreSQL Connection Tests', () {
    late ApiClient apiClient;

    test('Connection test succeeds with healthy server', () async {
      final mockClient = MockClient((request) async {
        if (request.url.path == '/api/health') {
          return http.Response(
            jsonEncode({
              'status': 'ok',
              'version': 'PostgreSQL 15.15',
              'tableCount': 43,
            }),
            200,
          );
        }
        return http.Response('Not Found', 404);
      });

      apiClient = ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: mockClient,
      );

      final result = await apiClient.testConnection();

      expect(result.success, isTrue);
      expect(result.serverVersion, equals('PostgreSQL 15.15'));
      expect(result.tableCount, equals(43));
    });

    test('Connection test fails with server error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      apiClient = ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: mockClient,
      );

      final result = await apiClient.testConnection();

      expect(result.success, isFalse);
      expect(result.message, contains('500'));
    });

    test('Sync sale succeeds', () async {
      final mockClient = MockClient((request) async {
        if (request.url.path == '/api/sales' && request.method == 'POST') {
          final body = jsonDecode(request.body);
          return http.Response(
            jsonEncode({
              'id': 'server-sale-id',
              'saleNumber': 'SALE-2024-001',
              'localId': body['localId'],
            }),
            201,
          );
        }
        return http.Response('Not Found', 404);
      });

      apiClient = ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: mockClient,
      );

      final result = await apiClient.syncSale({
        'localId': 'local-001',
        'tenantId': 'tenant-001',
        'branchId': 'branch-001',
        'totalAmount': 150.00,
      });

      expect(result.success, isTrue);
      expect(result.serverId, equals('server-sale-id'));
      expect(result.serverNumber, equals('SALE-2024-001'));
    });

    test('Fetch products returns list', () async {
      final mockClient = MockClient((request) async {
        if (request.url.path == '/api/products') {
          return http.Response(
            jsonEncode([
              {'id': 'prod-001', 'name': 'Product 1', 'code': 'P001'},
              {'id': 'prod-002', 'name': 'Product 2', 'code': 'P002'},
            ]),
            200,
          );
        }
        return http.Response('Not Found', 404);
      });

      apiClient = ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: mockClient,
      );

      final products = await apiClient.fetchProducts();

      expect(products.length, equals(2));
      expect(products[0]['name'], equals('Product 1'));
    });

    test('Tenant context is sent in headers', () async {
      String? receivedTenantId;

      final mockClient = MockClient((request) async {
        receivedTenantId = request.headers['X-Tenant-ID'];
        return http.Response(jsonEncode({'status': 'ok'}), 200);
      });

      apiClient = ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: mockClient,
      );
      apiClient.setTenantContext('tenant-123');

      await apiClient.testConnection();

      expect(receivedTenantId, equals('tenant-123'));
    });

    test('Auth token is sent in headers', () async {
      String? receivedAuth;

      final mockClient = MockClient((request) async {
        receivedAuth = request.headers['Authorization'];
        return http.Response(jsonEncode({'status': 'ok'}), 200);
      });

      apiClient = ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: mockClient,
      );
      apiClient.setAccessToken('test-token');

      await apiClient.testConnection();

      expect(receivedAuth, equals('Bearer test-token'));
    });
  });

  group('Offline-First Sync Flow', () {
    test('Sync flow: local → queue → server', () async {
      // This test validates the conceptual flow:
      // 1. Sale created locally (Drift)
      // 2. Added to sync queue
      // 3. When online, sent to server
      // 4. Local record updated with server ID

      final mockClient = MockClient((request) async {
        if (request.url.path == '/api/sales' && request.method == 'POST') {
          return http.Response(
            jsonEncode({
              'id': 'server-generated-id',
              'saleNumber': 'SALE-2024-100',
            }),
            201,
          );
        }
        return http.Response('Not Found', 404);
      });

      final apiClient = ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: mockClient,
      );
      apiClient.setTenantContext('tenant-001');

      // Simulate syncing a local sale
      final syncResult = await apiClient.syncSale({
        'localId': 'offline-sale-001',
        'tenantId': 'tenant-001',
        'branchId': 'branch-001',
        'items': [
          {'variantId': 'var-001', 'quantity': 2, 'unitPrice': 100},
        ],
        'totalAmount': 200,
      });

      expect(syncResult.success, isTrue);
      expect(syncResult.serverId, isNotNull);
      expect(syncResult.serverNumber, startsWith('SALE-'));
    });
  });
}
