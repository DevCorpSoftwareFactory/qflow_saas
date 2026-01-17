import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import 'catalog/product_list_screen.dart';

import 'dart:async';
import '../../di/injection.dart';
import '../../services/hardware/hardware_service.dart';
import '../../services/catalog_service.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/catalog/catalog_bloc.dart';
import '../blocs/cash_session/cash_session_bloc.dart';
import '../widgets/cart/cart_sidebar.dart';
import '../widgets/settings/printer_settings_dialog.dart';
import '../widgets/cash_session/cash_session_dialog.dart';
import '../widgets/cash_session/cash_movement_dialog.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final FocusNode _focusNode = FocusNode();
  // Using GetIt to access singleton services
  final HardwareService _hardwareService = getIt<HardwareService>();
  final CatalogService _catalogService = getIt<CatalogService>();
  StreamSubscription<String>? _scannerSubscription;

  @override
  void initState() {
    super.initState();
    // Listen to barcode scans
    _scannerSubscription =
        _hardwareService.onBarcodeScanned.listen(_onBarcodeScanned);

    // Check for open cash session
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<CashSessionBloc>().add(
            CashSessionCheckRequested(authState.userId),
          );
    }
  }

  @override
  void dispose() {
    _scannerSubscription?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _onBarcodeScanned(String code) async {
    // Search for product
    final products = await _catalogService.searchProducts(code);

    if (!mounted) return;

    if (products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto no encontrado: $code')),
      );
    } else if (products.length == 1) {
      // Exact match - Add to cart
      context.read<CartBloc>().add(CartItemAdded(products.first));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Agregado: ${products.first.productName}')),
      );
    } else {
      // Multiple matches (e.g. partial code) - Filter catalog
      context.read<CatalogBloc>().add(CatalogSearchChanged(code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CashSessionBloc, CashSessionState>(
      listener: (context, state) {
        if (state is CashSessionNone) {
          showDialog(
            context: context,
            barrierDismissible: false, // Force user to open session
            builder: (_) => const CashSessionDialog(),
          );
        } else if (state is CashSessionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _hardwareService.handleKeyEvent,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('QFlow POS'),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.point_of_sale),
                tooltip: 'Gestión de Caja',
                onSelected: (value) {
                  switch (value) {
                    case 'income':
                      showDialog(
                        context: context,
                        builder: (_) =>
                            const CashMovementDialog(type: MovementType.income),
                      );
                      break;
                    case 'expense':
                      showDialog(
                        context: context,
                        builder: (_) => const CashMovementDialog(
                            type: MovementType.expense),
                      );
                      break;
                    case 'withdrawal':
                      showDialog(
                        context: context,
                        builder: (_) => const CashMovementDialog(
                            type: MovementType.withdrawal),
                      );
                      break;
                    case 'close':
                      context.push('/cash-session/close');
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'income',
                    child: ListTile(
                      leading:
                          Icon(Icons.add_circle_outline, color: Colors.green),
                      title: Text('Ingreso Manual'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'expense',
                    child: ListTile(
                      leading: Icon(Icons.remove_circle_outline,
                          color: Colors.orange),
                      title: Text('Registrar Gasto'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'withdrawal',
                    child: ListTile(
                      leading: Icon(Icons.monetization_on_outlined,
                          color: Colors.blue),
                      title: Text('Retiro de Efectivo'),
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'close',
                    child: ListTile(
                      leading: Icon(Icons.lock_clock, color: Colors.red),
                      title: Text('Cerrar Caja'),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.print),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const PrinterSettingsDialog(),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                  context.go('/login');
                },
              ),
            ],
          ),
          body: Row(
            children: const [
              Expanded(child: ProductListScreen()),
              VerticalDivider(width: 1),
              CartSidebar(),
            ],
          ),
        ),
      ),
    );
  }
}
