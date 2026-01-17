import 'package:flutter_test/flutter_test.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/services/cash_session_service.dart';
import 'package:pos/services/hardware/receipt_generator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Needed for assets

  group('ReceiptGenerator', () {
    late ReceiptGenerator generator;

    setUp(() {
      generator = ReceiptGenerator();
    });

    test('generateSessionReport generates bytes', () async {
      // Setup data
      final session = LocalCashSession(
        id: 'session-123',
        tenantId: 'tenant-1',
        cashRegisterId: 'register-1',
        userId: 'user-1',
        initialAmount: 100000,
        status: SessionStatus.closed,
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        closingDate: DateTime.now(),
        declaredAmount: 150000,
        differenceJustification: null,
        systemAmount: 150000,
        // Missing fields fixed:
        openingDate: DateTime.now().subtract(const Duration(hours: 8)),
        synced: false,
        localId: 'local-123',
        updatedAt: DateTime.now(),
      );

      final summary = CashSessionSummary(
        session: session,
        totalIncome: 60000,
        totalExpenses: 5000,
        totalWithdrawals: 5000,
        salesCount: 10,
        movementsCount: 12,
        currentSystemAmount: 150000,
      );

      final bytes = await generator.generateSessionReport(
        summary: summary,
        tenantName: 'Test Tenant',
        branchName: 'Test Branch',
        cashierName: 'Test User',
        declaredAmount: 150000,
        difference: 0,
        justification: null,
      );

      expect(bytes, isNotEmpty);
      expect(bytes.length, greaterThan(100)); // Should have some content
    });
  });
}
