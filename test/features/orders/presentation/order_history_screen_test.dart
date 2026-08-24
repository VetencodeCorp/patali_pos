import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/database/database_provider.dart';
import 'package:patali_pos/data/repositories/cash_session_repository.dart';
import 'package:patali_pos/data/repositories/order_repository.dart';
import 'package:patali_pos/features/orders/presentation/order_history_screen.dart';
import 'package:patali_pos/features/orders/presentation/receipt_screen.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  testWidgets('voids order from history screen', (tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final cashSessions = CashSessionRepository(database);
    final orders = OrderRepository(database);
    final session = await cashSessions.openSession(openingCash: 0);
    final createdOrder = await orders.createCashOrder(
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
    final payment = await database.select(database.payments).getSingle();
    final historyItem = OrderListItem(order: createdOrder, payment: payment);

    final router = GoRouter(
      initialLocation: OrderHistoryScreen.routePath,
      routes: [
        GoRoute(
          path: OrderHistoryScreen.routePath,
          builder: (context, state) => const OrderHistoryScreen(),
        ),
        GoRoute(
          path: ReceiptScreen.routePath,
          builder: (context, state) {
            return ReceiptScreen(orderId: state.pathParameters['orderId']!);
          },
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          orderHistoryItemsProvider.overrideWith(
            (ref) => Stream.value([historyItem]),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('completed'), findsOneWidget);

    await tester.tap(find.byTooltip('Aksi transaksi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Batalkan'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Alasan'),
      'Salah input',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Batalkan transaksi'));
    await tester.pumpAndSettle();

    final voidedOrder = await database.select(database.orders).getSingle();

    expect(voidedOrder.status, 'voided');
    expect(voidedOrder.note, 'Salah input');
    expect(find.text('Transaksi dibatalkan'), findsOneWidget);
  });
}
