import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:patali_pos/core/config/patali_app.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/database/database_provider.dart';
import 'package:patali_pos/data/repositories/category_repository.dart';
import 'package:patali_pos/data/repositories/cash_session_repository.dart';
import 'package:patali_pos/data/repositories/product_repository.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  testWidgets('opens Patali POS dev flow', (tester) async {
    final now = DateTime(2026, 8, 22, 10, 0);
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    await database
        .into(database.roles)
        .insert(
          RolesCompanion.insert(
            id: devOwnerRoleId,
            name: 'Owner',
            code: 'owner',
          ),
        );
    await database
        .into(database.users)
        .insert(
          UsersCompanion.insert(
            id: devOwnerUserId,
            roleId: const Value(devOwnerRoleId),
            name: 'Owner Demo',
          ),
        );
    await database
        .into(database.cashSessions)
        .insert(
          CashSessionsCompanion.insert(
            id: 'cash-session-open',
            openedByUserId: devOwnerUserId,
            openedAt: now,
          ),
        );
    final openSession = CashSession(
      id: 'cash-session-open',
      openedByUserId: devOwnerUserId,
      openedAt: now,
      openingCash: 0,
      status: 'open',
      createdAt: now,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          activeCashSessionProvider.overrideWith(
            (ref) => Stream.value(openSession),
          ),
          activeCategoriesProvider.overrideWith((ref) => const Stream.empty()),
          filteredProductsProvider.overrideWith(
            (ref) => Stream.value([
              Product(
                id: 'prod-kopi-susu',
                name: 'Kopi Susu',
                price: 18000,
                trackStock: false,
                stockQty: 0,
                isActive: true,
                createdAt: now,
              ),
            ]),
          ),
        ],
        child: const PataliApp(),
      ),
    );

    expect(find.text('Patali POS'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(find.text('Mode development'), findsOneWidget);

    await tester.tap(find.text('Masuk sebagai Owner'));
    await tester.pumpAndSettle();

    expect(find.text('Patali Demo Outlet'), findsOneWidget);
    expect(find.text('Kopi Susu'), findsOneWidget);
    expect(find.textContaining('Kasir sedang buka'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pumpAndSettle();

    expect(find.text('Subtotal (1 item)'), findsOneWidget);
    expect(find.text('Rp 18.000'), findsWidgets);

    await tester.tap(find.byTooltip('Tambah'));
    await tester.pumpAndSettle();

    expect(find.text('2'), findsOneWidget);
    expect(find.text('Subtotal (2 item)'), findsOneWidget);
    expect(find.text('Rp 36.000'), findsWidgets);

    await tester.ensureVisible(find.text('Checkout'));
    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Checkout tunai berhasil'), findsOneWidget);
    expect(find.text('Struk'), findsOneWidget);
    expect(find.text('Patali Demo Outlet'), findsOneWidget);
    expect(find.text('Kopi Susu x2'), findsOneWidget);
  });
}
