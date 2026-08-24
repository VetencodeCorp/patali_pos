import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/promo_repository.dart';

void main() {
  late AppDatabase database;
  late PromoRepository promos;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    promos = PromoRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates updates deactivates and soft deletes promo', () async {
    final promo = await promos.createPromo(
      name: 'Diskon Opening',
      type: 'percent',
      value: 10,
    );

    expect(promo.name, 'Diskon Opening');
    expect(calculatePromoDiscount(promo, 100000), 10000);
    expect(promoValueLabel(promo), '10%');

    await promos.updatePromo(
      id: promo.id,
      name: 'Diskon Besar',
      type: 'amount',
      value: 15000,
    );

    var active = await promos.watchActivePromos().first;
    expect(active.single.name, 'Diskon Besar');
    expect(promoValueLabel(active.single), 'Rp 15.000');

    await promos.deactivatePromo(promo.id);
    active = await promos.watchActivePromos().first;
    expect(active, isEmpty);

    final second = await promos.createPromo(
      name: 'Diskon Weekend',
      type: 'amount',
      value: 5000,
    );
    await promos.deletePromo(second.id);

    final deleted = await promos.getPromoById(second.id);
    expect(deleted?.deletedAt, isNotNull);
    expect(deleted?.isActive, isFalse);
  });
}
