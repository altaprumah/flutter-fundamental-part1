import 'package:flutter/material.dart';

class RatingBadgeWidget extends StatelessWidget {
  final double rating;
  final int? terjual;
  final double fontSize;

  const RatingBadgeWidget({
    super.key,
    required this.rating,
    this.terjual,
    this.fontSize = 11.5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          color: Colors.amber,
          size: 16,
        ),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
          ),
        ),
        if (terjual != null) ...[
          const SizedBox(width: 4),
          Text(
            "•",
            style: TextStyle(fontSize: fontSize, color: Colors.grey.shade400),
          ),
          const SizedBox(width: 4),
          Text(
            "$terjual terjual",
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}
