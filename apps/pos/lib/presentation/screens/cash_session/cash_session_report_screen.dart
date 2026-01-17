import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pos/presentation/blocs/auth/auth_bloc.dart';
import 'package:pos/services/cash_session_service.dart';
import 'package:pos/services/hardware/hardware_service.dart';
import 'package:pos/services/hardware/receipt_generator.dart';

class CashSessionReportScreen extends StatefulWidget {
  final String sessionId;

  const CashSessionReportScreen({super.key, required this.sessionId});

  @override
  State<CashSessionReportScreen> createState() =>
      _CashSessionReportScreenState();
}

class _CashSessionReportScreenState extends State<CashSessionReportScreen> {
  late Future<CashSessionSummary> _summaryFuture;
  final _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
    locale: 'es_CO',
  );

  @override
  void initState() {
    super.initState();
    _summaryFuture = GetIt.I<CashSessionService>()
        .getSessionSummary(sessionId: widget.sessionId);
  }

  Future<void> _printReport(CashSessionSummary summary) async {
    try {
      final generator = GetIt.I<ReceiptGenerator>();
      final hardwareService = GetIt.I<HardwareService>();

      // Get user info from AuthBloc or fallback
      final authState = context.read<AuthBloc>().state;
      String cashierName = 'Desconocido';
      String tenantName = 'QFlow Pro';
      String branchName = 'Sucursal Principal';

      if (authState is AuthAuthenticated) {
        cashierName = authState.userName;
        tenantName = authState.tenantName;
        branchName = authState.branchName;
      }

      final declared = summary.session.declaredAmount ?? 0;
      final system = summary.currentSystemAmount;
      final diff = declared - system;

      final bytes = await generator.generateSessionReport(
        summary: summary,
        tenantName: tenantName,
        branchName: branchName,
        cashierName: cashierName,
        declaredAmount: declared,
        difference: diff,
        justification: summary.session.differenceJustification,
      );

      // Print via hardware service
      await hardwareService.printReceipt(bytes);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reporte impreso correctamente')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al imprimir: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte de Cierre'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'), // Go home or login
        ),
      ),
      body: FutureBuilder<CashSessionSummary>(
        future: _summaryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar reporte: ${snapshot.error}'),
            );
          }

          final summary = snapshot.data!;
          final session = summary.session;
          final declared = session.declaredAmount ?? 0;
          final system = summary.currentSystemAmount;
          final diff = declared - system;
          final isBalanced = diff.abs() <= 0.01;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'RESUMEN DE CAJA',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(session.createdAt),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (session.closingDate != null)
                          Text(
                            'Cierre: ${DateFormat('dd/MM/yyyy HH:mm').format(session.closingDate!)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // System Totals
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Movimientos del Sistema',
                            style: Theme.of(context).textTheme.titleMedium),
                        const Divider(),
                        _buildRow('Base Inicial', session.initialAmount),
                        _buildRow('Total Ingresos', summary.totalIncome),
                        _buildRow('Total Egresos', summary.totalExpenses,
                            isNegative: true),
                        _buildRow('Total Retiros', summary.totalWithdrawals,
                            isNegative: true),
                        const Divider(),
                        _buildRow('Total Esperado', system, isBold: true),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Reconciliation
                Card(
                  color: isBalanced
                      ? Colors.green.withValues(alpha: 0.05)
                      : (diff < 0
                          ? Colors.red.withValues(alpha: 0.05)
                          : Colors.orange.withValues(alpha: 0.05)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Arqueo (Físico vs Sistema)',
                            style: Theme.of(context).textTheme.titleMedium),
                        const Divider(),
                        _buildRow('Declarado', declared),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Diferencia:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              _currencyFormat.format(diff),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isBalanced
                                    ? Colors.green
                                    : (diff < 0 ? Colors.red : Colors.orange),
                              ),
                            ),
                          ],
                        ),
                        if (session.differenceJustification != null) ...[
                          const SizedBox(height: 16),
                          const Text('Justificación:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(session.differenceJustification!),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Actions
                FilledButton.icon(
                  onPressed: () => _printReport(summary),
                  icon: const Icon(Icons.print),
                  label: const Text('Imprimir Comprobante'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    // Logout
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    context.go('/login');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text('Cerrar Sesión'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRow(String label, double amount,
      {bool isNegative = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontWeight: isBold ? FontWeight.bold : null)),
          Text(
            (isNegative ? '-' : '') + _currencyFormat.format(amount),
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : null),
          ),
        ],
      ),
    );
  }
}
