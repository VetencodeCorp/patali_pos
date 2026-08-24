import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

const defaultSettingsId = 'default';

final appSettingsRepositoryProvider = Provider<AppSettingsRepository>((ref) {
  return AppSettingsRepository(ref.watch(appDatabaseProvider));
});

final appSettingsProvider = StreamProvider<AppSetting>((ref) {
  return ref.watch(appSettingsRepositoryProvider).watchSettings();
});

class AppSettingsRepository {
  AppSettingsRepository(this._database);

  final AppDatabase _database;

  Stream<AppSetting> watchSettings() async* {
    await ensureDefaultSettings();
    yield* (_database.select(
      _database.appSettings,
    )..where((setting) => setting.id.equals(defaultSettingsId))).watchSingle();
  }

  Future<AppSetting> getSettings() async {
    await ensureDefaultSettings();
    return (_database.select(
      _database.appSettings,
    )..where((setting) => setting.id.equals(defaultSettingsId))).getSingle();
  }

  Future<void> ensureDefaultSettings() async {
    await _database
        .into(_database.appSettings)
        .insert(
          AppSettingsCompanion.insert(id: defaultSettingsId),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> saveSettings({
    required String outletName,
    required String outletAddress,
    required String outletPhone,
    required String receiptHeader,
    required String receiptFooter,
    required bool taxEnabled,
    required int taxRate,
    required bool serviceEnabled,
    required int serviceRate,
    required bool showOutletAddress,
  }) async {
    if (outletName.trim().isEmpty) {
      throw ArgumentError.value(
        outletName,
        'outletName',
        'Nama outlet wajib diisi',
      );
    }
    if (taxRate < 0 || taxRate > 100) {
      throw ArgumentError.value(taxRate, 'taxRate', 'Pajak harus 0-100');
    }
    if (serviceRate < 0 || serviceRate > 100) {
      throw ArgumentError.value(
        serviceRate,
        'serviceRate',
        'Service charge harus 0-100',
      );
    }

    await ensureDefaultSettings();
    await (_database.update(
      _database.appSettings,
    )..where((setting) => setting.id.equals(defaultSettingsId))).write(
      AppSettingsCompanion(
        outletName: Value(outletName.trim()),
        outletAddress: Value(_nullable(outletAddress)),
        outletPhone: Value(_nullable(outletPhone)),
        receiptHeader: Value(_nullable(receiptHeader)),
        receiptFooter: Value(
          receiptFooter.trim().isEmpty ? 'Terima kasih' : receiptFooter.trim(),
        ),
        taxEnabled: Value(taxEnabled),
        taxRate: Value(taxEnabled ? taxRate : 0),
        serviceEnabled: Value(serviceEnabled),
        serviceRate: Value(serviceEnabled ? serviceRate : 0),
        showOutletAddress: Value(showOutletAddress),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  String? _nullable(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
