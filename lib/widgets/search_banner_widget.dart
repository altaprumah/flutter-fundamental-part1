import 'package:flutter/material.dart';

class SearchBannerWidget extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;

  const SearchBannerWidget({
    super.key,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: "Cari sayur, bumbu segar...",
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF7B1FA2),
                size: 20,
              ),
              suffixIcon: const Icon(
                Icons.tune_rounded,
                color: Color(0xFF7B1FA2),
                size: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Marketplace Promo Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF7B1FA2), // Purple 700
                Color(0xFF9C27B0), // Purple 500
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "PROMO SPESIAL",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Panen Segar Setiap Hari",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Diskon hingga 30% untuk produk lokal pilihan",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.local_shipping_outlined,
                color: Colors.white,
                size: 38,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
