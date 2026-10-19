import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pml/domain/barang.dart';
import 'package:pml/pages/detail_shoping_screen.dart';
import 'package:pml/pages/shoping_screen.dart';

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi Flutter
}

// Konfigurasi GoRouter untuk navigasi
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) => const ShopingScreen(),
      routes: [
        GoRoute(
          path: 'detail/:id', // Sub-route tidak menggunakan '/' di awal
          builder: (context, state) => DetailShopingScreen(
            id: state.pathParameters['id']!,
            barang: state.extra as Barang?,
          ),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan MaterialApp.router agar GoRouter berfungsi
    return MaterialApp.router(
      routerConfig: _router, // Menghubungkan konfigurasi router
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
    );
  }
}
