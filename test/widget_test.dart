import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pml/main.dart';

void main() {
  testWidgets('Master Plan: state dibagi lewat PlanProvider dan progres update',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MasterPlanApp());

    // Awal: belum ada tugas, footer menampilkan 0 dari 0.
    expect(find.text('Master Plan Althaf'), findsOneWidget);
    expect(find.text('0 out of 0 tasks'), findsOneWidget);

    // Tambah tugas -> footer ikut berubah.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('0 out of 1 tasks'), findsOneWidget);

    // Isi teks tugas.
    await tester.enterText(find.byType(TextFormField), 'Belajar Flutter');
    await tester.pump();
    expect(find.text('Belajar Flutter'), findsOneWidget);

    // Centang tugas -> footer menjadi 1 dari 1.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(find.text('1 out of 1 tasks'), findsOneWidget);
  });
}