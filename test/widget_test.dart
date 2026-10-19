import 'package:flutter/material.dart';
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

  testWidgets('Navigasi GoRouter ke halaman detail dan kembali ke katalog',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Pastikan item Mentimun ada di katalog
    final mentimunItem = find.text('Mentimun');
    expect(mentimunItem, findsOneWidget);

    // Klik item Mentimun untuk navigasi via GoRouter
    await tester.tap(mentimunItem);
    await tester.pumpAndSettle();

    // Verifikasi berada di halaman detail
    expect(find.text('Deskripsi Produk'), findsOneWidget);
    expect(find.text('Beli Sekarang'), findsOneWidget);
    expect(find.text('Jumlah Pembelian'), findsOneWidget);

    // Klik tombol kembali di AppBar
    final backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Verifikasi kembali ke halaman utama
    expect(find.text('Pasar Ungu'), findsOneWidget);
  });
}
