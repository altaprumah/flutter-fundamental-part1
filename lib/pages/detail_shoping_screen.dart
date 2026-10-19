import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pml/data/barang.dart';
import 'package:pml/domain/barang.dart';
import 'package:pml/widgets/app_footer_widget.dart';
import 'package:pml/widgets/detail_action_bar_widget.dart';
import 'package:pml/widgets/product_image_widget.dart';
import 'package:pml/widgets/rating_badge_widget.dart';
import 'package:pml/widgets/stock_badge_widget.dart';

class DetailShopingScreen extends StatefulWidget {
  final String id;
  final Barang? barang;

  const DetailShopingScreen({
    super.key,
    required this.id,
    this.barang,
  });

  @override
  State<DetailShopingScreen> createState() => _DetailShopingScreenState();
}

class _DetailShopingScreenState extends State<DetailShopingScreen> {
  late final Barang barang;
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    barang = widget.barang ??
        list_barang.firstWhere(
          (item) => item.id.toString() == widget.id,
          orElse: () => list_barang.first,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FA),
      body: CustomScrollView(
        slivers: [
          // Sliver AppBar dengan Hero Widget pada Gambar Produk
          SliverAppBar(
            expandedHeight: 330,
            pinned: true,
            backgroundColor: const Color(0xFF7B1FA2),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.4),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/');
                    }
                  },
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.redAccent : Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isFavorite
                                ? "Ditambahkan ke daftar favorit"
                                : "Dihapus dari favorit",
                          ),
                          backgroundColor: const Color(0xFF7B1FA2),
                          duration: const Duration(milliseconds: 900),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.white, size: 20),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                // Tag Hero harus sama persis dengan yang ada pada ItemBarangWidget
                tag: 'product-image-${barang.id}',
                child: ProductImageWidget(
                  imageUrl: barang.foto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Detail Konten Produk
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF7F4FA),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kartu Utama Informasi Produk
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Harga Produk
                        Text(
                          barang.hargaFormatted,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF7B1FA2), // Warna ungu utama
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Nama Produk
                        Text(
                          barang.nama_barang,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Rating, Terjual, dan Stok
                        Row(
                          children: [
                            RatingBadgeWidget(
                              rating: barang.rating,
                              terjual: barang.terjual,
                              fontSize: 13,
                            ),
                            const Spacer(),
                            StockBadgeWidget(stok: barang.stok),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Kategori & Jaminan Produk
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFeatureItem(
                          Icons.verified_outlined,
                          "100% Segar",
                          "Garansi panen baru",
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey.shade200,
                        ),
                        _buildFeatureItem(
                          Icons.local_shipping_outlined,
                          "Kirim Cepat",
                          "Tiba dalam 24 jam",
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey.shade200,
                        ),
                        _buildFeatureItem(
                          Icons.category_outlined,
                          barang.kategori,
                          "Kategori pilihan",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Jumlah Pembelian (Quantity Selector)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Jumlah Pembelian",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 16),
                                onPressed: _quantity > 1
                                    ? () => setState(() => _quantity--)
                                    : null,
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "$_quantity",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 16),
                                onPressed: _quantity < barang.stok
                                    ? () => setState(() => _quantity++)
                                    : null,
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Deskripsi Produk
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Deskripsi Produk",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          barang.deskripsi,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Footer Identitas Mahasiswa
                  const AppFooterWidget(isSticky: false),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),

      // Action Bar: Chat, Keranjang, Beli Sekarang
      bottomNavigationBar: DetailActionBarWidget(
        onAddToCart: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "$_quantity x ${barang.nama_barang} berhasil ditambahkan ke keranjang!",
              ),
              backgroundColor: const Color(0xFF7B1FA2),
            ),
          );
        },
        onBuyNow: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Melanjutkan checkout untuk $_quantity item...",
              ),
              backgroundColor: const Color(0xFF7B1FA2),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF7B1FA2), size: 22),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 9.5,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
