import 'package:flutter/material.dart';
import 'package:pml/pages/shoping_screen.dart';
import 'package:pml/pages/detail_shoping_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Belanja Ungu',
      debugShowCheckedModeBanner: false,
      // Mengatur tema utama aplikasi dengan warna dominan ungu
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B1FA2), // Ungu Primer
          primary: const Color(0xFF7B1FA2),
          secondary: const Color(0xFF9C27B0),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7B1FA2),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F4FA),
      ),
      // Rute navigasi halaman aplikasi
      initialRoute: '/',
      routes: {
        '/': (context) => const ShopingScreen(), // Halaman Utama (GridView)
        '/detail': (context) => const DetailShopingScreen(), // Halaman Detail Produk (Hero)
      },
    );
  }
}
