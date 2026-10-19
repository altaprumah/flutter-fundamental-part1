import 'package:flutter/material.dart';
import 'package:pml/data/barang.dart';
import 'package:pml/widgets/item_barang_widget.dart';

class ShopingScreen extends StatelessWidget {
  const ShopingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: list_barang.length,
          itemBuilder: (context, index) {
            final barang = list_barang[index];

            return ItemBarangWidget(barang: barang);
          },
        ),
      ),
    );
  }
}
