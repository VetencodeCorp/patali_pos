import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

const defaultPaymentSettingsId = 'default';

final paymentSettingsRepositoryProvider = Provider<PaymentSettingsRepository>((
  ref,
) {
  return PaymentSettingsRepository(ref.watch(appDatabaseProvider));
});

final paymentSettingsProvider = StreamProvider<PaymentSetting>((ref) {
  return ref.watch(paymentSettingsRepositoryProvider).watchSettings();
});

class PaymentSettingsRepository {
  PaymentSettingsRepository(this._database);

  final AppDatabase _database;

  Stream<PaymentSetting> watchSettings() async* {
    await ensureDefaultSettings();
    yield* (_database.select(_database.paymentSettings)
          ..where((setting) => setting.id.equals(defaultPaymentSettingsId)))
        .watchSingle();
  }

  Future<PaymentSetting> getSettings() async {
    await ensureDefaultSettings();
    return (_database.select(_database.paymentSettings)
          ..where((setting) => setting.id.equals(defaultPaymentSettingsId)))
        .getSingle();
  }

  Future<void> ensureDefaultSettings() async {
    await _database
        .into(_database.paymentSettings)
        .insert(
          PaymentSettingsCompanion.insert(id: defaultPaymentSettingsId),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> saveSettings({
    required bool qrisEnabled,
    required String qrisProvider,
    required String qrisMerchantId,
    required String qrisInstruction,
    required bool debitEnabled,
    required String debitProvider,
    required String debitMerchantId,
    required String debitInstruction,
    required bool transferEnabled,
    required String transferBankName,
    required String transferAccountNumber,
    required String transferAccountName,
    required String transferInstruction,
  }) async {
    await ensureDefaultSettings();
    await (_database.update(
      _database.paymentSettings,
    )..where((setting) => setting.id.equals(defaultPaymentSettingsId))).write(
      PaymentSettingsCompanion(
        qrisEnabled: Value(qrisEnabled),
        qrisProvider: Value(_nullable(qrisProvider)),
        qrisMerchantId: Value(_nullable(qrisMerchantId)),
        qrisInstruction: Value(_nullable(qrisInstruction)),
        debitEnabled: Value(debitEnabled),
        debitProvider: Value(_nullable(debitProvider)),
        debitMerchantId: Value(_nullable(debitMerchantId)),
        debitInstruction: Value(_nullable(debitInstruction)),
        transferEnabled: Value(transferEnabled),
        transferBankName: Value(_nullable(transferBankName)),
        transferAccountNumber: Value(_nullable(transferAccountNumber)),
        transferAccountName: Value(_nullable(transferAccountName)),
        transferInstruction: Value(_nullable(transferInstruction)),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  String? _nullable(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

List<String> activePaymentMethods(PaymentSetting? settings) {
  return [
    'cash',
    if (settings?.qrisEnabled ?? true) 'qris',
    if (settings?.debitEnabled ?? true) 'debit',
    if (settings?.transferEnabled ?? true) 'transfer',
  ];
}
