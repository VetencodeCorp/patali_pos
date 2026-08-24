import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/device_settings_repository.dart';

void main() {
  late AppDatabase database;
  late DeviceSettingsRepository settings;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    settings = DeviceSettingsRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates default device settings and saves LAN printer', () async {
    final initial = await settings.getSettings();

    expect(initial.printerType, 'bluetooth');
    expect(initial.paperWidth, 58);
    expect(initial.barcodeScannerEnabled, isTrue);

    await settings.saveSettings(
      printerType: 'lan',
      printerName: 'Kitchen Printer',
      printerAddress: '',
      printerIp: '192.168.1.50',
      printerPort: 9100,
      paperWidth: 80,
      cashDrawerEnabled: true,
      barcodeScannerEnabled: true,
    );

    final saved = await settings.getSettings();

    expect(saved.printerType, 'lan');
    expect(saved.printerName, 'Kitchen Printer');
    expect(saved.printerIp, '192.168.1.50');
    expect(saved.printerPort, 9100);
    expect(saved.paperWidth, 80);
    expect(saved.cashDrawerEnabled, isTrue);
  });
}
