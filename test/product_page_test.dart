import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pml/pages/product_page.dart';

void main() {
  testWidgets('ProductPage: loading lalu success', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ProductPage())),
    );

    // Loading: spinner tampil, data belum ada.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Keyboard'), findsNothing);

    // Setelah 2 detik: data tampil, spinner hilang.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Keyboard'), findsOneWidget);
    expect(find.text('Mouse'), findsOneWidget);
    expect(find.text('Monitor'), findsOneWidget);
  });
}