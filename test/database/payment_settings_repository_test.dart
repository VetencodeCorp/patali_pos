import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/payment_settings_repository.dart';

void main() {
  late AppDatabase database;
  late PaymentSettingsRepository settings;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    settings = PaymentSettingsRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates default payment settings and saves noncash methods', () async {
    final initial = await settings.getSettings();

    expect(initial.qrisEnabled, isTrue);
    expect(initial.debitEnabled, isTrue);
    expect(initial.transferEnabled, isTrue);
    expect(activePaymentMethods(initial), containsAll(['cash', 'qris']));

    await settings.saveSettings(
      qrisEnabled: true,
      qrisProvider: 'Midtrans',
      qrisMerchantId: 'MID-001',
      qrisImagePath: r'D:\qris\patali.png',
      qrisInstruction: 'Scan QRIS',
      debitEnabled: false,
      debitProvider: '',
      debitMerchantId: '',
      debitInstruction: '',
      transferEnabled: true,
      transferBankName: 'BCA',
      transferAccountNumber: '1234567890',
      transferAccountName: 'PT Patali',
      transferInstruction: 'Transfer lalu kirim bukti',
    );

    final saved = await settings.getSettings();

    expect(saved.qrisProvider, 'Midtrans');
    expect(saved.qrisImagePath, r'D:\qris\patali.png');
    expect(saved.debitEnabled, isFalse);
    expect(saved.transferBankName, 'BCA');
    expect(activePaymentMethods(saved), ['cash', 'qris', 'transfer']);
  });
}
