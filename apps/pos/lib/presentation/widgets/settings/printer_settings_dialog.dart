import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:pos/services/hardware/hardware_service.dart';
import 'package:pos/di/injection.dart';

class PrinterSettingsDialog extends StatefulWidget {
  const PrinterSettingsDialog({super.key});

  @override
  State<PrinterSettingsDialog> createState() => _PrinterSettingsDialogState();
}

class _PrinterSettingsDialogState extends State<PrinterSettingsDialog> {
  final HardwareService _hardwareService = getIt<HardwareService>();
  final List<PrinterDevice> _devices = [];
  StreamSubscription<PrinterDevice>? _scanSubscription;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    setState(() {
      _devices.clear();
      _isScanning = true;
    });

    // Scan for both Network and USB.
    // Ideally we might want separate scans or a combined stream manually managed.
    // For now, let's scan Network first as it's common.
    _scanSubscription = _hardwareService
        .scanPrinters(type: PrinterType.network)
        .listen((device) {
      setState(() {
        if (!_devices
            .any((d) => d.name == device.name && d.address == device.address)) {
          _devices.add(device);
        }
      });
    });

    // Auto-stop scanning after some time
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        _stopScan();
      }
    });
  }

  void _stopScan() {
    _scanSubscription?.cancel();
    if (mounted) {
      setState(() {
        _isScanning = false;
      });
    }
  }

  @override
  void dispose() {
    _stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectedDevice = _hardwareService.connectedDevice;

    return AlertDialog(
      title: const Text('Printer Settings'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Column(
          children: [
            if (_isScanning)
              const LinearProgressIndicator()
            else
              ElevatedButton.icon(
                onPressed: _startScan,
                icon: const Icon(Icons.refresh),
                label: const Text('Rescan'),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: _devices.isEmpty
                  ? const Center(child: Text('No printers found.'))
                  : ListView.builder(
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        final device = _devices[index];
                        final isConnected =
                            connectedDevice?.name == device.name &&
                                connectedDevice?.address == device.address;
                        return ListTile(
                          leading: Icon(Icons.print,
                              color: isConnected ? Colors.green : Colors.grey),
                          title: Text(device.name),
                          subtitle: Text(device.address ?? 'Unknown Address'),
                          trailing: isConnected
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : ElevatedButton(
                                  onPressed: () async {
                                    _stopScan();
                                    await _hardwareService.connect(
                                        device, PrinterType.network);
                                    setState(() {}); // Refresh UI
                                  },
                                  child: const Text('Connect'),
                                ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
