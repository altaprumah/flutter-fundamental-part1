import 'package:flutter/material.dart';
import 'package:pml/pages/shoping_screen.dart';
import 'package:pml/pages/detail_shoping_screen.dart';
// Note: Import barang.dart tidak dipakai di main.dart, jadi bisa dihapus jika tidak digunakan

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi Flutter
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // Mengatur tema warna utama aplikasi
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Mendaftarkan rute (navigasi) halaman
      routes: {
        '/': (context) => const ShopingScreen(), // Halaman utama (Home)
        '/detail': (context) => const DetailShopingScreen(), // Halaman detail
      },
    );
  }
}