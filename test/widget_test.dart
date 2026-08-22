import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/core/config/patali_app.dart';

void main() {
  testWidgets('opens Patali POS dev flow', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: PataliApp()));

    expect(find.text('Patali POS'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(find.text('Mode development'), findsOneWidget);

    await tester.tap(find.text('Masuk sebagai Owner'));
    await tester.pumpAndSettle();

    expect(find.text('Kasir'), findsOneWidget);
    expect(find.text('Kopi Susu'), findsOneWidget);
  });
}
