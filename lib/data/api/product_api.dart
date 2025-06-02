import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/product_model.dart';

class ProductApi {
  final String url = 'https://run.mocky.io/v3/05b09c74-fb01-4197-8f7d-c4c6fbcd189c';

  Future<Product> fetchProduct() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
