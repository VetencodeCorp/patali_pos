import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/database/database_provider.dart';
import 'package:patali_pos/features/settings/presentation/promo_management_screen.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  testWidgets(
    'shows validation error instead of red error when promo invalid',
    (tester) async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(database)],
          child: const MaterialApp(home: PromoManagementScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tambah Promo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan Promo'));
      await tester.pumpAndSettle();

      expect(find.text('Nama promo wajib diisi'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 1));
    },
  );

  testWidgets('creates promo from management screen', (tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const MaterialApp(home: PromoManagementScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tambah Promo'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Contoh: Diskon Opening'),
      'Diskon Kopi',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Contoh: 10000'),
      '5000',
    );
    await tester.tap(find.text('Simpan Promo'));
    await tester.pumpAndSettle();

    expect(find.text('Diskon Kopi'), findsOneWidget);
    expect(find.textContaining('Rp 5.000'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
