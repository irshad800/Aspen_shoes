import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/cart_model.dart';
import '../utils/constants.dart';

class CartServices {
  Future<List<CartModel>> getCart() async {
    final Uri url = Uri.parse('$baseUrl/api/cart/viewCart');

    try {
      final response = await http.get(url);
      print("responsecart:${response.body}");

      if (response.statusCode == 200) {
        print("status code:${response.statusCode}");
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] is List) {
          var cartList = (data['data'] as List)
              .map((item) => CartModel.fromJson(item as Map<String, dynamic>))
              .toList();
          print(cartList);

          return cartList;
        } else {
          throw Exception('The key "data" does not contain a list');
        }
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
