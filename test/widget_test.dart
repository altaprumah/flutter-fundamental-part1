import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pml/main.dart';

void main() {
  testWidgets('Master Plan: tambah tugas, isi teks, dan centang',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MasterPlanApp());

    // Awalnya judul tampil dan belum ada tugas.
    expect(find.text('Master Plan Althaf'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);

    // Tekan tombol '+' -> muncul satu tugas.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.byType(ListTile), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);

    // Isi deskripsi tugas.
    await tester.enterText(find.byType(TextFormField), 'Belajar Flutter');
    await tester.pump();
    expect(find.text('Belajar Flutter'), findsOneWidget);

    // Centang tugas -> status selesai.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    // Tambah tugas kedua -> ada dua tugas.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.byType(ListTile), findsNWidgets(2));
  });
}