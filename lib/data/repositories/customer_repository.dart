import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepository(ref.watch(appDatabaseProvider));
});

final customerSearchQueryProvider = StateProvider<String>((ref) => '');

final activeCustomersProvider = StreamProvider<List<Customer>>((ref) {
  final query = ref.watch(customerSearchQueryProvider).trim().toLowerCase();
  return ref.watch(customerRepositoryProvider).watchActiveCustomers().map((
    customers,
  ) {
    if (query.isEmpty) return customers;
    return customers.where((customer) {
      return customer.name.toLowerCase().contains(query) ||
          (customer.phone?.toLowerCase().contains(query) ?? false);
    }).toList();
  });
});

final customerByIdProvider = FutureProvider.family<Customer?, String>((
  ref,
  id,
) {
  return ref.watch(customerRepositoryProvider).getCustomerById(id);
});

class CustomerRepository {
  CustomerRepository(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Stream<List<Customer>> watchActiveCustomers() {
    final query = _database.select(_database.customers)
      ..where(
        (customer) =>
            customer.isActive.equals(true) & customer.deletedAt.isNull(),
      )
      ..orderBy([(customer) => OrderingTerm.asc(customer.name)]);

    return query.watch();
  }

  Future<Customer?> getCustomerById(String id) {
    return (_database.select(
      _database.customers,
    )..where((customer) => customer.id.equals(id))).getSingleOrNull();
  }

  Future<Customer> createCustomer({
    required String name,
    String? phone,
    String? email,
    String? address,
    String? note,
  }) async {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama pelanggan wajib diisi');
    }

    final id = _uuid.v4();
    await _database
        .into(_database.customers)
        .insert(
          CustomersCompanion.insert(
            id: id,
            name: name.trim(),
            phone: Value(_nullableTrim(phone)),
            email: Value(_nullableTrim(email)),
            address: Value(_nullableTrim(address)),
            note: Value(_nullableTrim(note)),
          ),
        );

    return (_database.select(
      _database.customers,
    )..where((customer) => customer.id.equals(id))).getSingle();
  }

  Future<void> updateCustomer({
    required String id,
    required String name,
    String? phone,
    String? email,
    String? address,
    String? note,
  }) async {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama pelanggan wajib diisi');
    }

    await (_database.update(
      _database.customers,
    )..where((customer) => customer.id.equals(id))).write(
      CustomersCompanion(
        name: Value(name.trim()),
        phone: Value(_nullableTrim(phone)),
        email: Value(_nullableTrim(email)),
        address: Value(_nullableTrim(address)),
        note: Value(_nullableTrim(note)),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deactivateCustomer(String id) async {
    await (_database.update(
      _database.customers,
    )..where((customer) => customer.id.equals(id))).write(
      CustomersCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteCustomer(String id) async {
    final now = DateTime.now();
    await (_database.update(
      _database.customers,
    )..where((customer) => customer.id.equals(id))).write(
      CustomersCompanion(
        isActive: const Value(false),
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }
}

String? _nullableTrim(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed;
}
