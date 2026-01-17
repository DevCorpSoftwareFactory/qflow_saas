import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/presentation/blocs/auth/auth_bloc.dart';
import 'package:pos/presentation/blocs/cash_session/cash_session_bloc.dart';

enum MovementType { income, expense, withdrawal }

class CashMovementDialog extends StatefulWidget {
  final MovementType type;

  const CashMovementDialog({super.key, required this.type});

  @override
  State<CashMovementDialog> createState() => _CashMovementDialogState();
}

class _CashMovementDialogState extends State<CashMovementDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _conceptController = TextEditingController();

  // For expenses only
  CashMovementCategory _selectedCategory = CashMovementCategory.expense;

  String get _title {
    switch (widget.type) {
      case MovementType.income:
        return 'Registrar Ingreso';
      case MovementType.expense:
        return 'Registrar Gasto';
      case MovementType.withdrawal:
        return 'Registrar Retiro';
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _conceptController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(_amountController.text) ?? 0;
      final concept = _conceptController.text;
      final authState = context.read<AuthBloc>().state;

      if (authState is AuthAuthenticated) {
        final bloc = context.read<CashSessionBloc>();
        final userId = authState.userId;

        switch (widget.type) {
          case MovementType.income:
            bloc.add(CashSessionIncomeRequested(
              amount: amount,
              concept: concept,
              userId: userId,
            ));
            break;
          case MovementType.expense:
            bloc.add(CashSessionExpenseRequested(
              amount: amount,
              concept: concept,
              userId: userId,
              category: _selectedCategory,
            ));
            break;
          case MovementType.withdrawal:
            bloc.add(CashSessionWithdrawalRequested(
              amount: amount,
              concept: concept,
              userId: userId,
            ));
            break;
        }
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el monto';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Monto inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _conceptController,
                decoration: const InputDecoration(
                  labelText: 'Concepto / Motivo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un concepto';
                  }
                  return null;
                },
              ),
              if (widget.type == MovementType.expense) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<CashMovementCategory>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  items: CashMovementCategory.values
                      .where((c) => c != CashMovementCategory.salesCash)
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c.name),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedCategory = v);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
