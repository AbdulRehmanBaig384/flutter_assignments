class Product {
  final String? id;
  final String name;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final String? idValue = json['_id']?.toString() ?? json['id']?.toString();
    
    double priceValue = 0.0;
    if (json['price'] != null) {
      if (json['price'] is num) {
        priceValue = (json['price'] as num).toDouble();
      } else {
        priceValue = double.tryParse(json['price'].toString()) ?? 0.0;
      }
    }

    return Product(
      id: idValue,
      name: json['name']?.toString() ?? '',
      price: priceValue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
