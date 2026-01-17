// =============================================================================
// Receipt Preview Screen
// =============================================================================
// Displays a visual preview of the sale receipt after checkout.
// Allows printing, sharing, or dismissing the receipt.
// =============================================================================

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../services/sales_service.dart';
import '../../../services/dto/create_sale_dto.dart';
import '../../../services/hardware/hardware_service.dart';
import '../../../services/hardware/receipt_generator.dart';
import '../../widgets/receipt/receipt_widget.dart';

/// Screen for previewing and printing a sale receipt.
class ReceiptPreviewScreen extends StatefulWidget {
  final SaleResult saleResult;
  final List<PaymentDto> payments;
  final String tenantName;
  final String branchName;
  final String cashierName;
  final double change;

  const ReceiptPreviewScreen({
    super.key,
    required this.saleResult,
    required this.payments,
    required this.tenantName,
    required this.branchName,
    required this.cashierName,
    required this.change,
  });

  /// Navigate to this screen after a successful sale.
  static void show(
    BuildContext context, {
    required SaleResult saleResult,
    required List<PaymentDto> payments,
    required String tenantName,
    required String branchName,
    required String cashierName,
    required double change,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReceiptPreviewScreen(
          saleResult: saleResult,
          payments: payments,
          tenantName: tenantName,
          branchName: branchName,
          cashierName: cashierName,
          change: change,
        ),
      ),
    );
  }

  @override
  State<ReceiptPreviewScreen> createState() => _ReceiptPreviewScreenState();
}

class _ReceiptPreviewScreenState extends State<ReceiptPreviewScreen> {
  final GlobalKey _receiptKey = GlobalKey();
  bool _isPrinting = false;
  bool _isSharing = false;

  late final HardwareService _hardwareService;
  late final ReceiptGenerator _receiptGenerator;

  @override
  void initState() {
    super.initState();
    _hardwareService = GetIt.instance<HardwareService>();
    _receiptGenerator = GetIt.instance<ReceiptGenerator>();
  }

  Future<void> _printReceipt() async {
    if (_isPrinting) return;

    setState(() => _isPrinting = true);

    try {
      // Check if printer is connected
      if (_hardwareService.connectedDevice == null) {
        _showMessage('No hay impresora conectada', isError: true);
        return;
      }

      // Generate ESC/POS bytes
      final bytes = await _receiptGenerator.generateReceiptFromResult(
        saleResult: widget.saleResult,
        payments: widget.payments,
        tenantName: widget.tenantName,
        branchName: widget.branchName,
        cashierName: widget.cashierName,
        change: widget.change,
      );

      // Print
      await _hardwareService.printReceipt(bytes);

      // Open cash drawer for cash payments
      final hasCashPayment =
          widget.payments.any((p) => p.method.name == 'cash');
      if (hasCashPayment) {
        await _hardwareService.openDrawer();
      }

      _showMessage('Recibo impreso correctamente');
    } catch (e) {
      _showMessage('Error al imprimir: $e', isError: true);
    } finally {
      setState(() => _isPrinting = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      // Capture the receipt widget as an image
      final imageBytes = await _captureReceiptImage();
      if (imageBytes == null) {
        _showMessage('Error al capturar el recibo', isError: true);
        return;
      }

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final fileName =
          'recibo_${widget.saleResult.saleNumber}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(imageBytes);

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Recibo de venta #${widget.saleResult.saleNumber}',
        subject: 'Recibo de Venta - ${widget.tenantName}',
      );

      _showMessage('Recibo compartido');
    } catch (e) {
      _showMessage('Error al compartir: $e', isError: true);
    } finally {
      setState(() => _isSharing = false);
    }
  }

  Future<Uint8List?> _captureReceiptImage() async {
    try {
      final boundary = _receiptKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing receipt image: $e');
      return null;
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Recibo de Venta'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Printer status indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              _hardwareService.connectedDevice != null
                  ? Icons.print
                  : Icons.print_disabled,
              color: _hardwareService.connectedDevice != null
                  ? Colors.green
                  : Colors.grey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Receipt Preview
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: RepaintBoundary(
                  key: _receiptKey,
                  child: ReceiptWidget(
                    saleResult: widget.saleResult,
                    payments: widget.payments,
                    tenantName: widget.tenantName,
                    branchName: widget.branchName,
                    cashierName: widget.cashierName,
                    change: widget.change,
                  ),
                ),
              ),
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Share Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isSharing ? null : _shareReceipt,
                      icon: _isSharing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.share),
                      label: const Text('Compartir'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Print Button
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: _isPrinting ? null : _printReceipt,
                      icon: _isPrinting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.print),
                      label: const Text('Imprimir'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Done Button
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () => Navigator.of(context).pop(),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Listo'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
