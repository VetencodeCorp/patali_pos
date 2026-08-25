import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/cash_session_repository.dart';
import 'package:patali_pos/data/repositories/order_repository.dart';
import 'package:patali_pos/data/repositories/product_repository.dart';

void main() {
  late AppDatabase database;
  late CashSessionRepository cashSessions;
  late OrderRepository orders;
  late ProductRepository products;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    cashSessions = CashSessionRepository(database);
    orders = OrderRepository(database);
    products = ProductRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('watches order history with payment method filter', () async {
    final session = await cashSessions.openSession(openingCash: 0);

    await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 18000,
      discountTotal: 0,
      grandTotal: 18000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 1,
          unitPrice: 18000,
          lineTotal: 18000,
        ),
      ],
    );
    await orders.createCashOrder(
      cashSessionId: session.id,
      paymentMethod: 'qris',
      subtotal: 36000,
      discountTotal: 0,
      grandTotal: 36000,
      items: const [
        CreateOrderItem(
          productId: 'prod-latte',
          productName: 'Latte',
          qty: 2,
          unitPrice: 18000,
          lineTotal: 36000,
        ),
      ],
    );

    final history = await orders.watchOrderHistory(paymentMethod: 'qris').first;

    expect(history, hasLength(1));
    expect(history.single.order.grandTotal, 36000);
    expect(history.single.payment?.method, 'qris');
  });

  test('stores selected order type', () async {
    final session = await cashSessions.openSession(openingCash: 0);

    final order = await orders.createCashOrder(
      cashSessionId: session.id,
      orderType: 'Meja',
      subtotal: 18000,
      discountTotal: 0,
      grandTotal: 18000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 1,
          unitPrice: 18000,
          lineTotal: 18000,
        ),
      ],
    );

    expect(order.orderType, 'Meja');
  });

  test('stores manual discount and promo name', () async {
    final session = await cashSessions.openSession(openingCash: 0);

    final order = await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 50000,
      manualDiscountTotal: 5000,
      discountTotal: 10000,
      promoName: 'Diskon Kopi',
      grandTotal: 40000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 1,
          unitPrice: 50000,
          lineTotal: 50000,
        ),
      ],
    );

    expect(order.manualDiscountTotal, 5000);
    expect(order.discountTotal, 10000);
    expect(order.promoName, 'Diskon Kopi');
  });

  test('loads customer in history and receipt', () async {
    final session = await cashSessions.openSession(openingCash: 0);
    await database
        .into(database.customers)
        .insert(CustomersCompanion.insert(id: 'cust-andi', name: 'Andi'));

    final order = await orders.createCashOrder(
      cashSessionId: session.id,
      customerId: 'cust-andi',
      subtotal: 18000,
      discountTotal: 0,
      grandTotal: 18000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 1,
          unitPrice: 18000,
          lineTotal: 18000,
        ),
      ],
    );

    final history = await orders.watchOrderHistory().first;
    final receipt = await orders.getReceipt(order.id);

    expect(history.single.customer?.name, 'Andi');
    expect(receipt.customer?.name, 'Andi');
  });

  test('watches kitchen orders and updates item status', () async {
    final session = await cashSessions.openSession(openingCash: 0);
    await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 35000,
      discountTotal: 0,
      grandTotal: 35000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 1,
          unitPrice: 18000,
          lineTotal: 18000,
        ),
        CreateOrderItem(
          productId: 'prod-roti-bakar',
          productName: 'Roti Bakar',
          qty: 1,
          unitPrice: 17000,
          lineTotal: 17000,
        ),
      ],
    );

    var kitchen = await orders.watchKitchenOrders().first;

    expect(kitchen, hasLength(1));
    expect(kitchen.single.items, hasLength(2));
    expect(kitchen.single.items.first.kitchenStatus, 'pending');

    await orders.updateKitchenStatus(
      orderItemId: kitchen.single.items.first.id,
      status: 'ready',
    );
    kitchen = await orders.watchKitchenOrders().first;

    expect(kitchen.single.items.first.kitchenStatus, 'ready');

    for (final item in kitchen.single.items) {
      await orders.updateKitchenStatus(orderItemId: item.id, status: 'served');
    }
    kitchen = await orders.watchKitchenOrders().first;

    expect(kitchen, isEmpty);
  });

  test('builds order number from cashier invoice settings', () async {
    final session = await cashSessions.openSession(openingCash: 0);

    final first = await orders.createCashOrder(
      cashSessionId: session.id,
      invoicePrefix: 'POS',
      resetInvoiceDaily: true,
      subtotal: 18000,
      discountTotal: 0,
      grandTotal: 18000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 1,
          unitPrice: 18000,
          lineTotal: 18000,
        ),
      ],
    );
    final second = await orders.createCashOrder(
      cashSessionId: session.id,
      invoicePrefix: 'POS',
      resetInvoiceDaily: true,
      subtotal: 18000,
      discountTotal: 0,
      grandTotal: 18000,
      items: const [
        CreateOrderItem(
          productId: 'prod-latte',
          productName: 'Latte',
          qty: 1,
          unitPrice: 18000,
          lineTotal: 18000,
        ),
      ],
    );

    expect(first.orderNumber, startsWith('POS-'));
    expect(first.orderNumber, endsWith('-0001'));
    expect(second.orderNumber, endsWith('-0002'));
  });

  test('voids completed order and payment', () async {
    final session = await cashSessions.openSession(openingCash: 0);
    final order = await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 18000,
      discountTotal: 0,
      grandTotal: 18000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 1,
          unitPrice: 18000,
          lineTotal: 18000,
        ),
      ],
    );

    await orders.voidOrder(order.id, reason: 'Salah input');

    final updatedOrder = await database.select(database.orders).getSingle();
    final payment = await database.select(database.payments).getSingle();
    final syncItems = await database.select(database.syncQueue).get();

    expect(updatedOrder.status, 'voided');
    expect(updatedOrder.note, 'Salah input');
    expect(payment.status, 'voided');
    expect(syncItems.last.action, 'void');
  });

  test('decreases tracked stock on checkout and restores on void', () async {
    final session = await cashSessions.openSession(openingCash: 0);
    final product = await products.createProduct(
      name: 'Kopi Susu',
      price: 18000,
      trackStock: true,
      stockQty: 5,
    );

    final order = await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 36000,
      discountTotal: 0,
      grandTotal: 36000,
      items: [
        CreateOrderItem(
          productId: product.id,
          productName: product.name,
          qty: 2,
          unitPrice: product.price,
          lineTotal: 36000,
        ),
      ],
    );

    var updatedProduct = await database.select(database.products).getSingle();
    var movements = await database.select(database.stockMovements).get();
    expect(updatedProduct.stockQty, 3);
    expect(movements.single.source, 'sale');
    expect(movements.single.qtyChange, -2);

    await orders.voidOrder(order.id);

    updatedProduct = await database.select(database.products).getSingle();
    movements = await database.select(database.stockMovements).get();
    expect(updatedProduct.stockQty, 5);
    expect(movements, hasLength(2));
    expect(movements.last.source, 'void_restore');
    expect(movements.last.qtyChange, 2);
  });

  test('rejects checkout when tracked stock is insufficient', () async {
    final session = await cashSessions.openSession(openingCash: 0);
    final product = await products.createProduct(
      name: 'Kopi Susu',
      price: 18000,
      trackStock: true,
      stockQty: 1,
    );

    expect(
      () => orders.createCashOrder(
        cashSessionId: session.id,
        subtotal: 36000,
        discountTotal: 0,
        grandTotal: 36000,
        items: [
          CreateOrderItem(
            productId: product.id,
            productName: product.name,
            qty: 2,
            unitPrice: product.price,
            lineTotal: 36000,
          ),
        ],
      ),
      throwsA(isA<StateError>()),
    );
  });
}
