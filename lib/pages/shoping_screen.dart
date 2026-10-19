import 'package:flutter/material.dart';
import 'package:pml/data/barang.dart';

class ShopingScreen extends StatelessWidget {
  const ShopingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shoping List"),
        backgroundColor: Colors.blue,
      ),
      // Wadah utama halaman dengan padding di sekelilingnya
      body: Container(
        padding: const EdgeInsets.all(20),
        // Membuat daftar item yang efisien sesuai jumlah data
        child: ListView.builder(
          itemCount: list_barang.length, // Jumlah item sesuai data list_barang
          itemBuilder: (context, index) {
            final barang = list_barang[index]; // Mengambil data barang berdasarkan indeks
            
            // Mendeteksi sentuhan/klik pada item
            return GestureDetector(
              onTap: () {
                // Pindah ke halaman detail sambil membawa data barang yang dipilih
                Navigator.pushNamed(context, '/detail', arguments: barang);
              },
              // Tampilan visual untuk setiap item dalam daftar
              child: Container(
                color: Colors.tealAccent,
                margin: const EdgeInsets.symmetric(vertical: 3), // Jarak antar item
                padding: const EdgeInsets.all(5),
                child: Text(barang.nama_barang), // Menampilkan nama barang
              ),
            );
          },
        ),
      ),
    );
  }
}