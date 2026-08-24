import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/cash_session_repository.dart';
import 'package:patali_pos/data/repositories/order_repository.dart';
import 'package:patali_pos/data/repositories/sales_summary_repository.dart';

void main() {
  late AppDatabase database;
  late CashSessionRepository cashSessions;
  late OrderRepository orders;
  late SalesSummaryRepository salesSummary;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    cashSessions = CashSessionRepository(database);
    orders = OrderRepository(database);
    salesSummary = SalesSummaryRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('summarizes daily sales', () async {
    final session = await cashSessions.openSession(openingCash: 0);

    await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 36000,
      discountTotal: 0,
      grandTotal: 36000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 2,
          unitPrice: 18000,
          lineTotal: 36000,
        ),
      ],
    );

    final summary = await salesSummary.getDailySummary(DateTime.now());

    expect(summary.totalSales, 36000);
    expect(summary.cashSales, 36000);
    expect(summary.nonCashSales, 0);
    expect(summary.orderCount, 1);
    expect(summary.averageOrderValue, 36000);
  });

  test('summarizes daily sales after transaction discount', () async {
    final session = await cashSessions.openSession(openingCash: 0);

    await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 36000,
      discountTotal: 6000,
      grandTotal: 30000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 2,
          unitPrice: 18000,
          lineTotal: 36000,
        ),
      ],
    );

    final summary = await salesSummary.getDailySummary(DateTime.now());

    expect(summary.totalSales, 30000);
    expect(summary.cashSales, 30000);
    expect(summary.orderCount, 1);
    expect(summary.averageOrderValue, 30000);
  });

  test('summarizes non-cash payment methods', () async {
    final session = await cashSessions.openSession(openingCash: 0);

    await orders.createCashOrder(
      cashSessionId: session.id,
      paymentMethod: 'qris',
      subtotal: 36000,
      discountTotal: 0,
      grandTotal: 36000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 2,
          unitPrice: 18000,
          lineTotal: 36000,
        ),
      ],
    );

    final payments = await database.select(database.payments).get();
    final summary = await salesSummary.getDailySummary(DateTime.now());

    expect(payments.single.method, 'qris');
    expect(summary.totalSales, 36000);
    expect(summary.cashSales, 0);
    expect(summary.nonCashSales, 36000);
  });

  test('excludes voided orders from daily sales', () async {
    final session = await cashSessions.openSession(openingCash: 0);
    final order = await orders.createCashOrder(
      cashSessionId: session.id,
      subtotal: 36000,
      discountTotal: 0,
      grandTotal: 36000,
      items: const [
        CreateOrderItem(
          productId: 'prod-kopi-susu',
          productName: 'Kopi Susu',
          qty: 2,
          unitPrice: 18000,
          lineTotal: 36000,
        ),
      ],
    );

    await orders.voidOrder(order.id);

    final summary = await salesSummary.getDailySummary(DateTime.now());

    expect(summary.totalSales, 0);
    expect(summary.cashSales, 0);
    expect(summary.nonCashSales, 0);
    expect(summary.orderCount, 0);
  });
}
