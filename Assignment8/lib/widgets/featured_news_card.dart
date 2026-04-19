import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class FeaturedNewsCard extends StatelessWidget {
  final NewsItem news;

  const FeaturedNewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Featured badge using Stack
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  "assets/images/home1.png",
                  width: double.infinity, // stretch full card width
                  fit: BoxFit.cover,
                ),
              ),
              // Featured Badge - Positioned
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'FEATURED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    news.category,
                    style: const TextStyle(
                      color: AppTheme.badgeText,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  news.title,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.description,
                  style: const TextStyle(
                    color: AppTheme.textMedium,
                    fontSize: 13,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF4A7A95);

    // Main building
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.25, size.width * 0.5,
          size.height * 0.75),
      paint,
    );

    // Windows
    final windowPaint = Paint()..color = const Color(0xFFB0D4E8);
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 5; col++) {
        canvas.drawRect(
          Rect.fromLTWH(
            size.width * 0.18 + col * (size.width * 0.09),
            size.height * 0.30 + row * (size.height * 0.16),
            size.width * 0.06,
            size.height * 0.10,
          ),
          windowPaint,
        );
      }
    }

    // Side building
    final sidePaint = Paint()..color = const Color(0xFF3D6B85);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.68, size.height * 0.40, size.width * 0.25,
          size.height * 0.60),
      sidePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
