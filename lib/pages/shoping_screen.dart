import 'package:flutter/material.dart';
import 'package:pml/data/barang.dart';
import 'package:pml/domain/barang.dart';
import 'package:pml/widgets/app_footer_widget.dart';
import 'package:pml/widgets/category_chips_widget.dart';
import 'package:pml/widgets/item_barang_widget.dart';
import 'package:pml/widgets/search_banner_widget.dart';

class ShopingScreen extends StatefulWidget {
  const ShopingScreen({super.key});

  @override
  State<ShopingScreen> createState() => _ShopingScreenState();
}

class _ShopingScreenState extends State<ShopingScreen> {
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  final List<String> _categories = [
    'Semua',
    'Sayuran Buah',
    'Bumbu Dapur',
    'Umbi-umbian',
    'Sayuran Daun',
  ];

  List<Barang> get _filteredBarang {
    return list_barang.where((item) {
      final matchCategory = _selectedCategory == 'Semua' ||
          item.kategori.toLowerCase() == _selectedCategory.toLowerCase();
      final matchQuery = _searchQuery.isEmpty ||
          item.nama_barang.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCategory && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredBarang;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FA), // Background bernuansa ungu lembut
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF7B1FA2), // Tema Ungu
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.storefront_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pasar Ungu",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Belanja Segar & Murah",
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Fitur keranjang belanja"),
                  backgroundColor: Color(0xFF7B1FA2),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 6),
        ],
      ),

      // Footer Mahasiswa di bagian bawah (sticky footer)
      bottomNavigationBar: const AppFooterWidget(isSticky: true),

      body: CustomScrollView(
        slivers: [
          // Header: Search Bar & Promo Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: SearchBannerWidget(
                onSearchChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
              ),
            ),
          ),

          // Kategori Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: CategoryChipsWidget(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onSelectCategory: (cat) {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
              ),
            ),
          ),

          // Header Jumlah Produk
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daftar Produk (${items.length})",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  Text(
                    "Terlengkap & Berkualitas",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // GridView Produk Marketplace
          if (items.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 64,
                      color: Colors.purple.shade200,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Produk tidak ditemukan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Coba ubah kata kunci pencarian atau kategori",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final barang = items[index];
                    return ItemBarangWidget(barang: barang);
                  },
                  childCount: items.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
