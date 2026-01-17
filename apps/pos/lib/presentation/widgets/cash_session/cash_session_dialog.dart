import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/presentation/blocs/auth/auth_bloc.dart';
import 'package:pos/presentation/blocs/cash_session/cash_session_bloc.dart';
import 'package:pos/services/cash_session_service.dart';
import 'package:get_it/get_it.dart';

class CashSessionDialog extends StatefulWidget {
  const CashSessionDialog({super.key});

  @override
  State<CashSessionDialog> createState() => _CashSessionDialogState();
}

class _CashSessionDialogState extends State<CashSessionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController(text: '0');
  bool _isLoading = false;
  String? _registerId;
  String? _registerName;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDefaultRegister();
  }

  Future<void> _loadDefaultRegister() async {
    setState(() => _isLoading = true);
    try {
      final service = GetIt.I<CashSessionService>();
      final register = await service.getDefaultRegister();
      if (register != null) {
        setState(() {
          _registerId = register.id;
          _registerName = register.name;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'No active cash register found. Please configure one.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error loading register: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_registerId == null) return;

      final amount = double.tryParse(_amountController.text) ?? 0;
      final authState = context.read<AuthBloc>().state;

      if (authState is AuthAuthenticated) {
        context.read<CashSessionBloc>().add(
              CashSessionOpenRequested(
                tenantId: authState.tenantId,
                cashRegisterId: _registerId!,
                userId: authState.userId,
                initialAmount: amount,
              ),
            );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Open Cash Session'),
      content: SizedBox(
        width: 400,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Text(_error!, style: const TextStyle(color: Colors.red))
                : Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register: ${_registerName ?? "Unknown"}',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            labelText: 'Initial Float Amount',
                            prefixText: '\$ ',
                            border: OutlineInputBorder(),
                            hintText: '0.00',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an amount';
                            }
                            final amount = double.tryParse(value);
                            if (amount == null || amount < 0) {
                              return 'Invalid amount';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
      ),
      actions: [
        if (_error == null && !_isLoading)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        if (_error == null && !_isLoading)
          FilledButton(
            onPressed: _submit,
            child: const Text('Open Session'),
          ),
        if (_error != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
      ],
    );
  }
}
