import 'package:flutter_test/flutter_test.dart';
import 'package:pml/main.dart';

void main() {
  testWidgets('Aplikasi Belanja menampilkan judul dan footer identitas',
      (WidgetTester tester) async {
    // Build aplikasi belanja
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verifikasi nama toko dan identitas mahasiswa di footer
    expect(find.text('Pasar Ungu'), findsOneWidget);
    expect(find.text('Muhammad Althaf Farrel Natajaya'), findsOneWidget);
    expect(find.text('NIM: 24.52.0004'), findsOneWidget);
  });
}
