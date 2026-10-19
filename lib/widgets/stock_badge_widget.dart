import 'package:flutter/material.dart';

class StockBadgeWidget extends StatelessWidget {
  final int stok;

  const StockBadgeWidget({super.key, required this.stok});

  @override
  Widget build(BuildContext context) {
    final isLow = stok <= 15;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: isLow
            ? Colors.deepOrange.shade50
            : const Color(0xFFF3E5F5), // Purple 50
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isLow
              ? Colors.deepOrange.shade200
              : const Color(0xFFCE93D8), // Purple 200
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isLow ? Icons.warning_amber_rounded : Icons.inventory_2_outlined,
            size: 11,
            color: isLow ? Colors.deepOrange.shade700 : const Color(0xFF7B1FA2),
          ),
          const SizedBox(width: 3),
          Text(
            isLow ? "Sisa $stok" : "Stok: $stok",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isLow
                  ? Colors.deepOrange.shade800
                  : const Color(0xFF6A1B9A),
            ),
          ),
        ],
      ),
    );
  }
}
