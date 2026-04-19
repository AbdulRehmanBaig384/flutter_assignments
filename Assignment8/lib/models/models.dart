// lib/models/product.dart

class Product {
  final String id;
  final String title;
  final String category;
  final double price;
  final String condition;
  final String imageUrl;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.condition,
    required this.imageUrl,
  });
}

// lib/models/news_item.dart

class NewsItem {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final bool isFeatured;

  const NewsItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.isFeatured = false,
  });
}
