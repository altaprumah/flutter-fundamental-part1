import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pml/main.dart';

void main() {
  testWidgets('Master Plan: state dibagi antar dua screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MasterPlanApp());

    // Screen 1 kosong.
    expect(find.text('Master Plans Althaf'), findsOneWidget);
    expect(find.text('Anda belum memiliki rencana apapun.'), findsOneWidget);

    // Tambah plan baru.
    await tester.enterText(find.byType(TextField), 'Belajar Flutter');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('0 out of 0 tasks'), findsOneWidget);

    // Buka screen 2, tambah tugas, lalu centang.
    await tester.tap(find.text('Belajar Flutter'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('0 out of 1 tasks'), findsOneWidget);
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('1 out of 1 tasks'), findsOneWidget);

    // Kembali ke screen 1: progres ikut ter-update (state dibagi).
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('1 out of 1 tasks'), findsOneWidget);
  });
}