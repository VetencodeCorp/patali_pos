import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/customer_repository.dart';

void main() {
  late AppDatabase database;
  late CustomerRepository customers;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    customers = CustomerRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates updates deactivates and soft deletes customer', () async {
    final created = await customers.createCustomer(
      name: 'Andi Saputra',
      phone: '081234567890',
      email: 'andi@email.com',
      address: 'Jl. Merdeka',
      note: 'Suka kopi tanpa gula',
    );

    expect(created.name, 'Andi Saputra');
    expect(created.phone, '081234567890');

    await customers.updateCustomer(
      id: created.id,
      name: 'Andi S.',
      phone: '081111111111',
    );

    final updated = await customers.getCustomerById(created.id);
    expect(updated?.name, 'Andi S.');
    expect(updated?.phone, '081111111111');

    await customers.deactivateCustomer(created.id);
    var active = await customers.watchActiveCustomers().first;
    expect(active, isEmpty);

    final second = await customers.createCustomer(name: 'Budi');
    await customers.deleteCustomer(second.id);
    active = await customers.watchActiveCustomers().first;
    expect(active, isEmpty);

    final deleted = await customers.getCustomerById(second.id);
    expect(deleted?.deletedAt, isNotNull);
    expect(deleted?.isActive, isFalse);
  });
}
