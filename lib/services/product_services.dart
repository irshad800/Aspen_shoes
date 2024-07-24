import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../utils/constants.dart';

class ProductServices {
  Future<List<ProductModel>> getProducts() async {
    final Uri url = Uri.parse('$baseUrl/api/product/viewProduct');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> data = json.decode(response.body);

        // Ensure 'data' contains a list of products
        if (data['data'] is List) {
          var productList = (data['data'] as List)
              .map(
                  (item) => ProductModel.fromJson(item as Map<String, dynamic>))
              .toList();

          return productList;
        } else {
          throw Exception('The key "data" does not contain a list');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
