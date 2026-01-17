import 'dart:async';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:flutter/services.dart';

class HardwareService {
  final PrinterManager _printerManager;

  HardwareService({PrinterManager? printerManager})
      : _printerManager = printerManager ?? PrinterManager.instance;

  // Wrapper to store type since PrinterDevice might not have it
  PrinterDevice? _connectedDevice;
  PrinterType? _connectedType;

  PrinterDevice? get connectedDevice => _connectedDevice;

  Stream<PrinterDevice> scanPrinters({PrinterType type = PrinterType.network}) {
    return _printerManager.discovery(type: type);
  }

  Future<void> connect(PrinterDevice device, PrinterType type) async {
    if (_connectedDevice != null && _connectedDevice!.name == device.name) {
      return;
    }

    await _printerManager.connect(
      type: type,
      model: BluetoothPrinterInput(
        name: device.name,
        address: device.address!,
        isBle: false,
      ),
    );

    _connectedDevice = device;
    _connectedType = type;
  }

  Future<void> disconnect() async {
    if (_connectedDevice != null && _connectedType != null) {
      await _printerManager.disconnect(type: _connectedType!);
      _connectedDevice = null;
      _connectedType = null;
    }
  }

  Future<void> printReceipt(List<int> bytes) async {
    if (_connectedDevice == null || _connectedType == null) {
      throw Exception('No printer connected');
    }

    await _printerManager.send(type: _connectedType!, bytes: bytes);
  }

  Future<void> openDrawer() async {
    if (_connectedDevice == null || _connectedType == null) {
      return;
    }

    final List<int> pulseCommand = [0x1B, 0x70, 0x00, 0x19, 0xFA];

    await _printerManager.send(type: _connectedType!, bytes: pulseCommand);
  }

  // --- Scanner Logic ---
  final _scannedCodeController = StreamController<String>.broadcast();
  Stream<String> get onBarcodeScanned => _scannedCodeController.stream;

  String _buffer = '';
  Timer? _bufferTimer;

  void handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (_buffer.isNotEmpty) {
          _scannedCodeController.add(_buffer);
          _buffer = '';
        }
      } else {
        // Simple alphanumeric check - expand as needed
        if (event.character != null &&
            event.character!.isNotEmpty &&
            !_isControlKey(event.logicalKey)) {
          _buffer += event.character!;

          // Reset timer (debounce/timeout) to clear buffer if typing stops (e.g. manual entry mixed with scan)
          _bufferTimer?.cancel();
          _bufferTimer = Timer(const Duration(milliseconds: 500), () {
            _buffer = '';
          });
        }
      }
    }
  }

  bool _isControlKey(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.shiftLeft ||
        key == LogicalKeyboardKey.shiftRight ||
        key == LogicalKeyboardKey.controlLeft ||
        key == LogicalKeyboardKey.controlRight ||
        key == LogicalKeyboardKey.altLeft ||
        key == LogicalKeyboardKey.altRight ||
        key == LogicalKeyboardKey.metaLeft ||
        key == LogicalKeyboardKey.metaRight;
  }

  void dispose() {
    _scannedCodeController.close();
    _bufferTimer?.cancel();
  }
}
