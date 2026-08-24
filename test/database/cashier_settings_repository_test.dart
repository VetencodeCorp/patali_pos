import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/cashier_settings_repository.dart';

void main() {
  late AppDatabase database;
  late CashierSettingsRepository settings;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    settings = CashierSettingsRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates default cashier settings and saves defaults', () async {
    final initial = await settings.getSettings();

    expect(initial.invoicePrefix, 'INV');
    expect(initial.defaultPaymentMethod, 'cash');
    expect(initial.defaultOrderType, 'Bungkus');
    expect(initial.manualDiscountEnabled, isTrue);

    await settings.saveSettings(
      invoicePrefix: 'POS',
      resetInvoiceDaily: false,
      defaultPaymentMethod: 'qris',
      defaultOrderType: 'Meja',
      manualDiscountEnabled: false,
      customerRequired: true,
    );

    final saved = await settings.getSettings();

    expect(saved.invoicePrefix, 'POS');
    expect(saved.resetInvoiceDaily, isFalse);
    expect(saved.defaultPaymentMethod, 'qris');
    expect(saved.defaultOrderType, 'Meja');
    expect(saved.manualDiscountEnabled, isFalse);
    expect(saved.customerRequired, isTrue);
  });
}
