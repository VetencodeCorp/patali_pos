import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/cash_session_repository.dart';
import 'package:patali_pos/data/repositories/order_repository.dart';

void main() {
  late AppDatabase database;
  late CashSessionRepository cashSessions;
  late OrderRepository orders;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    cashSessions = CashSessionRepository(database);
    orders = OrderRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('closes cash session with expected cash from cash sales', () async {
    final session = await cashSessions.openSession(openingCash: 100000);

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

    await cashSessions.closeSession(sessionId: session.id, closingCash: 136000);

    final closedSession = await database
        .select(database.cashSessions)
        .getSingle();

    expect(closedSession.status, 'closed');
    expect(closedSession.expectedCash, 136000);
    expect(closedSession.closingCash, 136000);
  });
}
