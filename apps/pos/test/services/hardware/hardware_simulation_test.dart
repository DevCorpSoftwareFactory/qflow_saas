import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:pos/services/hardware/hardware_service.dart';

// Generate mock for PrinterManager
@GenerateMocks([PrinterManager])
import 'hardware_simulation_test.mocks.dart';

void main() {
  late HardwareService hardwareService;
  late MockPrinterManager mockPrinterManager;

  setUp(() {
    mockPrinterManager = MockPrinterManager();
    hardwareService = HardwareService(printerManager: mockPrinterManager);
  });

  group('HardwareService Simulation', () {
    test('scanPrinters calls discovery on manager', () {
      // Arrange
      final device = PrinterDevice(
        name: 'Test Printer',
        address: '192.168.1.100',
      );
      when(
        mockPrinterManager.discovery(type: PrinterType.network),
      ).thenAnswer((_) => Stream.value(device));

      // Act
      final stream = hardwareService.scanPrinters(type: PrinterType.network);

      // Assert
      expect(stream, emits(device));
      verify(mockPrinterManager.discovery(type: PrinterType.network)).called(1);
    });

    test('connect establishes connection and stores device', () async {
      // Arrange
      final device = PrinterDevice(
        name: 'Test Printer',
        address: '192.168.1.100',
      );
      when(
        mockPrinterManager.connect(
          type: PrinterType.network,
          model: anyNamed('model'),
        ),
      ).thenAnswer((_) async => true);

      // Act
      await hardwareService.connect(device, PrinterType.network);

      // Assert
      expect(hardwareService.connectedDevice, equals(device));
      verify(
        mockPrinterManager.connect(
          type: PrinterType.network,
          model: anyNamed('model'),
        ),
      ).called(1);
    });

    test('printReceipt throws if not connected', () async {
      // Act & Assert
      expect(() => hardwareService.printReceipt([1, 2, 3]), throwsException);
    });

    test('printReceipt sends bytes when connected', () async {
      // Arrange
      final device = PrinterDevice(
        name: 'Test Printer',
        address: '192.168.1.100',
      );
      when(
        mockPrinterManager.connect(
          type: PrinterType.network,
          model: anyNamed('model'),
        ),
      ).thenAnswer((_) async => true);
      await hardwareService.connect(device, PrinterType.network);

      when(
        mockPrinterManager.send(
          type: PrinterType.network,
          bytes: anyNamed('bytes'),
        ),
      ).thenAnswer((_) async => true);

      // Act
      final bytes = [0x1B, 0x40]; // Init
      await hardwareService.printReceipt(bytes);

      // Assert
      verify(
        mockPrinterManager.send(type: PrinterType.network, bytes: bytes),
      ).called(1);
    });

    test('openDrawer sends pulse command', () async {
      // Arrange
      final device = PrinterDevice(
        name: 'Test Printer',
        address: '192.168.1.100',
      );
      when(
        mockPrinterManager.connect(
          type: PrinterType.network,
          model: anyNamed('model'),
        ),
      ).thenAnswer((_) async => true);
      await hardwareService.connect(device, PrinterType.network);

      when(
        mockPrinterManager.send(
          type: PrinterType.network,
          bytes: anyNamed('bytes'),
        ),
      ).thenAnswer((_) async => true);

      // Act
      await hardwareService.openDrawer();

      // Assert
      // Expected pulse command: [0x1B, 0x70, 0x00, 0x19, 0xFA]
      final expectedBytes = [0x1B, 0x70, 0x00, 0x19, 0xFA];
      verify(
        mockPrinterManager.send(
          type: PrinterType.network,
          bytes: expectedBytes,
        ),
      ).called(1);
    });
  });
}
