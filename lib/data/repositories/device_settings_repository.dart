import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

const defaultDeviceSettingsId = 'default';

final deviceSettingsRepositoryProvider = Provider<DeviceSettingsRepository>((
  ref,
) {
  return DeviceSettingsRepository(ref.watch(appDatabaseProvider));
});

final deviceSettingsProvider = StreamProvider<DeviceSetting>((ref) {
  return ref.watch(deviceSettingsRepositoryProvider).watchSettings();
});

class DeviceSettingsRepository {
  DeviceSettingsRepository(this._database);

  final AppDatabase _database;

  Stream<DeviceSetting> watchSettings() async* {
    await ensureDefaultSettings();
    yield* (_database.select(_database.deviceSettings)
          ..where((setting) => setting.id.equals(defaultDeviceSettingsId)))
        .watchSingle();
  }

  Future<DeviceSetting> getSettings() async {
    await ensureDefaultSettings();
    return (_database.select(_database.deviceSettings)
          ..where((setting) => setting.id.equals(defaultDeviceSettingsId)))
        .getSingle();
  }

  Future<void> ensureDefaultSettings() async {
    await _database
        .into(_database.deviceSettings)
        .insert(
          DeviceSettingsCompanion.insert(id: defaultDeviceSettingsId),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<void> saveSettings({
    required String printerType,
    required String printerName,
    required String printerAddress,
    required String printerIp,
    required int printerPort,
    required int paperWidth,
    required bool cashDrawerEnabled,
    required bool barcodeScannerEnabled,
  }) async {
    if (printerType != 'bluetooth' && printerType != 'lan') {
      throw ArgumentError.value(
        printerType,
        'printerType',
        'Tipe printer tidak valid',
      );
    }
    if (printerPort < 1 || printerPort > 65535) {
      throw ArgumentError.value(
        printerPort,
        'printerPort',
        'Port harus 1-65535',
      );
    }
    if (paperWidth != 58 && paperWidth != 80) {
      throw ArgumentError.value(
        paperWidth,
        'paperWidth',
        'Lebar kertas harus 58 atau 80',
      );
    }

    await ensureDefaultSettings();
    await (_database.update(
      _database.deviceSettings,
    )..where((setting) => setting.id.equals(defaultDeviceSettingsId))).write(
      DeviceSettingsCompanion(
        printerType: Value(printerType),
        printerName: Value(_nullable(printerName)),
        printerAddress: Value(_nullable(printerAddress)),
        printerIp: Value(_nullable(printerIp)),
        printerPort: Value(printerPort),
        paperWidth: Value(paperWidth),
        cashDrawerEnabled: Value(cashDrawerEnabled),
        barcodeScannerEnabled: Value(barcodeScannerEnabled),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  String? _nullable(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
