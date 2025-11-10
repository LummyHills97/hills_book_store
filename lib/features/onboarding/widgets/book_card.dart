import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imagePath;
  final double price;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140, // ✅ consistent card width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Reduced height to avoid overflow
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 160, // ✅ reduced from 180
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 6), // ✅ reduced spacing

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13, // ✅ reduced font
                fontWeight: FontWeight.w600,
              ),
            ),

            Text(
              author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11, // ✅ reduced
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 4), // ✅ spacing tuned

            Text(
              "₦${price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 13, // ✅ reduced a bit
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A5E20), // ✅ deep green
              ),
            ),
          ],
        ),
      ),
    );
  }
}
