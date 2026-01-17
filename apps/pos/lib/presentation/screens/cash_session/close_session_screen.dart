import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/blocs/cash_session/cash_session_bloc.dart';
import 'package:intl/intl.dart';

class CloseSessionScreen extends StatefulWidget {
  const CloseSessionScreen({super.key});

  @override
  State<CloseSessionScreen> createState() => _CloseSessionScreenState();
}

class _CloseSessionScreenState extends State<CloseSessionScreen> {
  final _amountController = TextEditingController();
  final _justificationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Steps: 0 = Declare Amount (Blind), 1 = Review & Justify
  int _currentStep = 0;
  double? _declaredAmount;

  // Formatters
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  @override
  void dispose() {
    _amountController.dispose();
    _justificationController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _declaredAmount = double.parse(_amountController.text);
        _currentStep = 1;
      });
    }
  }

  void _onSubmit() {
    if (_declaredAmount == null) return;

    // Justification is required if there is a difference (checked in service, but we can enforce here too if we want strict UI)
    // The service allows close with difference if justification is provided.

    // Check justification if difference exists (we can see the diff now in step 1)
    final currentState = context.read<CashSessionBloc>().state;
    if (currentState is CashSessionActive) {
      final systemAmount = currentState.summary.currentSystemAmount;
      final diff = _declaredAmount! - systemAmount;

      if (diff.abs() > 0.01 && _justificationController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor justifique la diferencia')),
        );
        return;
      }
    }

    context.read<CashSessionBloc>().add(
          CashSessionCloseRequested(
            declaredAmount: _declaredAmount!,
            justification: _justificationController.text.isNotEmpty
                ? _justificationController.text
                : null,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cierre de Caja')),
      body: BlocConsumer<CashSessionBloc, CashSessionState>(
        listener: (context, state) {
          if (state is CashSessionClosed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Caja cerrada exitosamente')),
            );
            // Navigate to report screen
            context.go('/cash-session/report/${state.result.sessionId}');
            // Do not logout here, let user logout from report screen
            // context.read<AuthBloc>().add(AuthLogoutRequested());
          } else if (state is CashSessionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is CashSessionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is! CashSessionActive) {
            return const Center(child: Text('No hay sesión activa'));
          }

          final systemAmount = state.summary.currentSystemAmount;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: _currentStep == 0
                ? _buildDeclarationStep()
                : _buildReviewStep(systemAmount),
          );
        },
      ),
    );
  }

  Widget _buildDeclarationStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Ingrese el efectivo total en caja',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Cuente billetes y monedas antes de ingresar el monto.',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          TextFormField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Monto Declarado',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(20),
            ),
            style: const TextStyle(fontSize: 32),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese el monto';
              if (double.tryParse(value) == null) return 'Monto inválido';
              return null;
            },
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          FilledButton(
            onPressed: _onNext,
            style: FilledButton.styleFrom(padding: const EdgeInsets.all(20)),
            child: const Text('Continuar a Revisión',
                style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep(double systemAmount) {
    final diff = (_declaredAmount ?? 0) - systemAmount;
    final isBalanced = diff.abs() <= 0.01;
    final hasShortage = diff < -0.01;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Resumen de Cierre',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _buildSummaryRow('Declarado (Tú):', _declaredAmount ?? 0, isBold: true),
        const Divider(),
        _buildSummaryRow('Esperado (Sistema):', systemAmount),
        const Divider(),
        _buildSummaryRow('Diferencia:', diff,
            color: isBalanced
                ? Colors.green
                : (hasShortage ? Colors.red : Colors.orange),
            isBold: true),
        const SizedBox(height: 32),
        if (!isBalanced) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hasShortage
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: hasShortage ? Colors.red : Colors.orange),
            ),
            child: Column(
              children: [
                Icon(
                  hasShortage ? Icons.warning : Icons.info,
                  color: hasShortage ? Colors.red : Colors.orange,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  hasShortage
                      ? 'Faltante de dinero detectado'
                      : 'Sobrante de dinero detectado',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: hasShortage ? Colors.red : Colors.orange,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _justificationController,
                  decoration: const InputDecoration(
                    labelText: 'Justificación (Obligatorio)',
                    border: OutlineInputBorder(),
                    helperText: 'Explique la razón de la diferencia',
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ] else ...[
          const Center(
            child: Text(
              '✅ Caja Cuadrada',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep = 0),
                style:
                    OutlinedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Text('Corregir Monto'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: _onSubmit,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: isBalanced ? Colors.green : Colors.red,
                ),
                child:
                    const Text('Cerrar Caja', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount,
      {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            _currencyFormat.format(amount),
            style: TextStyle(
                fontSize: 18,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color),
          ),
        ],
      ),
    );
  }
}
