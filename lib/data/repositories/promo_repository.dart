import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

final promoRepositoryProvider = Provider<PromoRepository>((ref) {
  return PromoRepository(ref.watch(appDatabaseProvider));
});

final activePromosProvider = StreamProvider<List<Promo>>((ref) {
  return ref.watch(promoRepositoryProvider).watchActivePromos();
});

final promoByIdProvider = FutureProvider.family<Promo?, String>((ref, id) {
  return ref.watch(promoRepositoryProvider).getPromoById(id);
});

class PromoRepository {
  PromoRepository(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Stream<List<Promo>> watchActivePromos() {
    final query = _database.select(_database.promos)
      ..where((promo) => promo.isActive.equals(true) & promo.deletedAt.isNull())
      ..orderBy([(promo) => OrderingTerm.asc(promo.name)]);

    return query.watch();
  }

  Future<List<Promo>> getActivePromos() {
    final query = _database.select(_database.promos)
      ..where((promo) => promo.isActive.equals(true) & promo.deletedAt.isNull())
      ..orderBy([(promo) => OrderingTerm.asc(promo.name)]);

    return query.get();
  }

  Future<Promo?> getPromoById(String id) {
    return (_database.select(
      _database.promos,
    )..where((promo) => promo.id.equals(id))).getSingleOrNull();
  }

  Future<Promo> createPromo({
    required String name,
    required String type,
    required int value,
  }) async {
    _validate(name: name, type: type, value: value);
    final id = _uuid.v4();
    await _database
        .into(_database.promos)
        .insert(
          PromosCompanion.insert(
            id: id,
            name: name.trim(),
            type: type,
            value: value,
          ),
        );

    return (_database.select(
      _database.promos,
    )..where((promo) => promo.id.equals(id))).getSingle();
  }

  Future<void> updatePromo({
    required String id,
    required String name,
    required String type,
    required int value,
  }) async {
    _validate(name: name, type: type, value: value);
    await (_database.update(
      _database.promos,
    )..where((promo) => promo.id.equals(id))).write(
      PromosCompanion(
        name: Value(name.trim()),
        type: Value(type),
        value: Value(value),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deactivatePromo(String id) async {
    await (_database.update(
      _database.promos,
    )..where((promo) => promo.id.equals(id))).write(
      PromosCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deletePromo(String id) async {
    final now = DateTime.now();
    await (_database.update(
      _database.promos,
    )..where((promo) => promo.id.equals(id))).write(
      PromosCompanion(
        isActive: const Value(false),
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  void _validate({
    required String name,
    required String type,
    required int value,
  }) {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama promo wajib diisi');
    }
    if (type != 'amount' && type != 'percent') {
      throw ArgumentError.value(type, 'type', 'Tipe promo tidak valid');
    }
    if (value <= 0) {
      throw ArgumentError.value(
        value,
        'value',
        'Nilai promo harus lebih dari 0',
      );
    }
    if (type == 'percent' && value > 100) {
      throw ArgumentError.value(value, 'value', 'Persen maksimal 100');
    }
  }
}

int calculatePromoDiscount(Promo? promo, int subtotal) {
  if (promo == null || subtotal <= 0) return 0;
  final discount = promo.type == 'percent'
      ? (subtotal * promo.value / 100).round()
      : promo.value;
  return discount.clamp(0, subtotal);
}

String promoValueLabel(Promo promo) {
  if (promo.type == 'percent') return '${promo.value}%';
  final raw = promo.value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    final left = raw.length - i;
    buffer.write(raw[i]);
    if (left > 1 && left % 3 == 1) buffer.write('.');
  }
  return 'Rp $buffer';
}
