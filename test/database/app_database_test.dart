import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('stores local POS transaction data', () async {
    final now = DateTime(2026, 8, 22, 10, 0);

    await database
        .into(database.roles)
        .insert(
          RolesCompanion.insert(id: 'role-owner', name: 'Owner', code: 'owner'),
        );
    await database
        .into(database.users)
        .insert(
          UsersCompanion.insert(
            id: 'user-owner',
            roleId: const Value('role-owner'),
            name: 'Owner Demo',
          ),
        );
    await database
        .into(database.categories)
        .insert(CategoriesCompanion.insert(id: 'cat-drink', name: 'Minuman'));
    await database
        .into(database.products)
        .insert(
          ProductsCompanion.insert(
            id: 'prod-kopi-susu',
            categoryId: const Value('cat-drink'),
            name: 'Kopi Susu',
            price: 18000,
          ),
        );
    await database
        .into(database.cashSessions)
        .insert(
          CashSessionsCompanion.insert(
            id: 'cash-session-1',
            openedByUserId: 'user-owner',
            openedAt: now,
            openingCash: const Value(100000),
          ),
        );
    await database
        .into(database.orders)
        .insert(
          OrdersCompanion.insert(
            id: 'order-1',
            cashSessionId: const Value('cash-session-1'),
            cashierUserId: const Value('user-owner'),
            orderNumber: 'INV-0001',
            subtotal: const Value(36000),
            grandTotal: const Value(36000),
            orderedAt: now,
          ),
        );
    await database
        .into(database.orderItems)
        .insert(
          OrderItemsCompanion.insert(
            id: 'order-item-1',
            orderId: 'order-1',
            productId: const Value('prod-kopi-susu'),
            productName: 'Kopi Susu',
            qty: 2,
            unitPrice: 18000,
            lineTotal: 36000,
          ),
        );
    await database
        .into(database.payments)
        .insert(
          PaymentsCompanion.insert(
            id: 'payment-1',
            orderId: 'order-1',
            method: 'cash',
            amount: 36000,
            paidAt: now,
          ),
        );

    final orders = await database.select(database.orders).get();
    final items = await database.select(database.orderItems).get();
    final payments = await database.select(database.payments).get();

    expect(orders.single.orderNumber, 'INV-0001');
    expect(items.single.productName, 'Kopi Susu');
    expect(payments.single.method, 'cash');
  });
}
