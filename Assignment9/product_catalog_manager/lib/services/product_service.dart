import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products from server (Status Code: ${response.statusCode})');
    }
  }

  Future<Product> addProduct(Product product) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add product (Status Code: ${response.statusCode})');
    }
  }

  Future<void> updateProduct(Product product) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/${product.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update product (Status Code: ${response.statusCode})');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}/$id');
    final response = await http.delete(url);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete product (Status Code: ${response.statusCode})');
    }
  }
}
