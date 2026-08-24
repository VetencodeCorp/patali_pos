import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

const defaultCashierSettingsId = 'default';

final cashierSettingsRepositoryProvider = Provider<CashierSettingsRepository>((
  ref,
) {
  return CashierSettingsRepository(ref.watch(appDatabaseProvider));
});

final cashierSettingsProvider = StreamProvider<CashierSetting>((ref) {
  return ref.watch(cashierSettingsRepositoryProvider).watchSettings();
});

class CashierSettingsRepository {
  CashierSettingsRepository(this._database);

  final AppDatabase _database;

  Stream<CashierSetting> watchSettings() async* {
    await ensureDefaultSettings();
    yield* (_database.select(_database.cashierSettings)
          ..where((setting) => setting.id.equals(defaultCashierSettingsId)))
        .watchSingle();
  }

  Future<CashierSetting> getSettings() async {
    await ensureDefaultSettings();
    return (_database.select(_database.cashierSettings)
          ..where((setting) => setting.id.equals(defaultCashierSettingsId)))
        .getSingle();
  }

  Future<void> ensureDefaultSettings() async {
    await _database
        .into(_database.cashierSettings)
        .insert(
          CashierSettingsCompanion.insert(id: defaultCashierSettingsId),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> saveSettings({
    required String invoicePrefix,
    required bool resetInvoiceDaily,
    required String defaultPaymentMethod,
    required String defaultOrderType,
    required bool manualDiscountEnabled,
    required bool customerRequired,
  }) async {
    final prefix = invoicePrefix.trim().toUpperCase();
    if (prefix.isEmpty) {
      throw ArgumentError.value(
        invoicePrefix,
        'invoicePrefix',
        'Prefix invoice wajib diisi',
      );
    }
    if (!RegExp(r'^[A-Z0-9_-]{2,10}$').hasMatch(prefix)) {
      throw ArgumentError.value(
        invoicePrefix,
        'invoicePrefix',
        'Prefix hanya A-Z, 0-9, _ atau -',
      );
    }
    if (!_paymentMethods.contains(defaultPaymentMethod)) {
      throw ArgumentError.value(
        defaultPaymentMethod,
        'defaultPaymentMethod',
        'Metode bayar tidak valid',
      );
    }
    if (!_orderTypes.contains(defaultOrderType)) {
      throw ArgumentError.value(
        defaultOrderType,
        'defaultOrderType',
        'Jenis order tidak valid',
      );
    }

    await ensureDefaultSettings();
    await (_database.update(
      _database.cashierSettings,
    )..where((setting) => setting.id.equals(defaultCashierSettingsId))).write(
      CashierSettingsCompanion(
        invoicePrefix: Value(prefix),
        resetInvoiceDaily: Value(resetInvoiceDaily),
        defaultPaymentMethod: Value(defaultPaymentMethod),
        defaultOrderType: Value(defaultOrderType),
        manualDiscountEnabled: Value(manualDiscountEnabled),
        customerRequired: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

const _paymentMethods = {'cash', 'qris', 'debit', 'transfer'};

const _orderTypes = {
  'Meja',
  'Free Table',
  'Bungkus',
  'Pengiriman',
  'Ojek Online',
  'Quick Service',
  'Reservasi',
};
