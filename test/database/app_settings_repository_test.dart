import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/app_settings_repository.dart';

void main() {
  late AppDatabase database;
  late AppSettingsRepository settings;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    settings = AppSettingsRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates default settings and saves receipt settings', () async {
    final initial = await settings.getSettings();

    expect(initial.outletName, 'Patali Demo Outlet');
    expect(initial.receiptFooter, 'Terima kasih');

    await settings.saveSettings(
      outletName: 'Patali Coffee',
      outletAddress: 'Jl. Merdeka No. 10',
      outletPhone: '081234567890',
      receiptHeader: 'Selamat datang',
      receiptFooter: 'Datang lagi',
      taxEnabled: true,
      taxRate: 10,
      serviceEnabled: true,
      serviceRate: 5,
      showOutletAddress: true,
    );

    final saved = await settings.getSettings();

    expect(saved.outletName, 'Patali Coffee');
    expect(saved.outletAddress, 'Jl. Merdeka No. 10');
    expect(saved.receiptHeader, 'Selamat datang');
    expect(saved.receiptFooter, 'Datang lagi');
    expect(saved.taxEnabled, isTrue);
    expect(saved.taxRate, 10);
    expect(saved.serviceEnabled, isTrue);
    expect(saved.serviceRate, 5);
  });
}
