import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pml/domain/barang.dart';
import 'package:pml/widgets/product_image_widget.dart';
import 'package:pml/widgets/rating_badge_widget.dart';
import 'package:pml/widgets/stock_badge_widget.dart';

// Widget kartu produk untuk tampilan GridView marketplace
class ItemBarangWidget extends StatelessWidget {
  final Barang barang;

  const ItemBarangWidget({super.key, required this.barang});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFF3E5F5), // Light purple border
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A1B9A).withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            // Navigasi ke halaman detail menggunakan GoRouter sesuai praktikum 2
            context.go('/detail/${barang.id}', extra: barang);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Gambar Produk dengan Hero Widget
              Expanded(
                flex: 11,
                child: Stack(
                  children: [
                    Positioned.fill(
                      // Implementasi Hero Animation sesuai dokumentasi Flutter
                      child: Hero(
                        tag: 'product-image-${barang.id}',
                        child: ProductImageWidget(
                          imageUrl: barang.foto,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    // Badge Kategori Produk
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          barang.kategori,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // Badge Sisa Stok
                    Positioned(
                      top: 8,
                      right: 8,
                      child: StockBadgeWidget(stok: barang.stok),
                    ),
                  ],
                ),
              ),

              // Bagian Informasi Produk
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nama Produk
                      Text(
                        barang.nama_barang,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E2E2E),
                          height: 1.2,
                        ),
                      ),

                      // Rating & Terjual
                      RatingBadgeWidget(
                        rating: barang.rating,
                        terjual: barang.terjual,
                        fontSize: 11,
                      ),

                      // Harga & Tombol Aksi Keranjang
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              barang.hargaFormatted,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF7B1FA2), // Warna ungu utama
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B1FA2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}