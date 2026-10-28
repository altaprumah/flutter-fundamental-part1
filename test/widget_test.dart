import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pml/main.dart';

void main() {
  testWidgets('ToDo: tambah, centang, dan hapus tugas',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Awal: belum ada tugas.
    expect(find.text('ToDo Riverpod'), findsOneWidget);
    expect(find.text('Belum ada tugas'), findsOneWidget);

    // Tambah tugas lewat dialog.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Belajar Riverpod');
    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();
    expect(find.text('Belajar Riverpod'), findsOneWidget);
    expect(find.text('Belum ada tugas'), findsNothing);

    // Centang tugas -> teks tercoret.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(
      tester.widget<Text>(find.text('Belajar Riverpod')).style?.decoration,
      TextDecoration.lineThrough,
    );

    // Hapus tugas -> kembali kosong.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    expect(find.text('Belum ada tugas'), findsOneWidget);
  });
}