import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/cart_model.dart';
import '../model/product_model.dart';
import '../utils/constants.dart';

class CartService {
  // Add product to cart
  Future<void> addProductToCart({
    required String userid,
    required ProductModel product,
  }) async {
    final Uri url = Uri.parse('$baseUrl/api/cart/addToCart');

    final Map<String, dynamic> cartData = {
      'userid': userid,
      'productid': product.sId,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cartData),
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        print('Product added to cart successfully');
      } else if (response.statusCode == 200) {
        final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
            GlobalKey<ScaffoldMessengerState>();

        Scaffold(
          key: scaffoldMessengerKey,
        );
        void showCustomSnackBar(String message) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text("already added"),
            ),
          );
        }
      } else {
        print('3');
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<CartModel>> getCartContents(String userid) async {
    final Uri url = Uri.parse('$baseUrl/api/cart/viewCart/$userid');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        if (data['data'] is List) {
          var cartList = (data['data'] as List)
              .map((item) => CartModel.fromJson(item as Map<String, dynamic>))
              .toList();
          print('Cart list: $cartList');

          return cartList;
        } else {
          throw Exception('The key "data" is missing or the list is null');
        }
      } else {
        throw Exception('Failed to load cart contents');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Remove product from cart
  Future<void> removeProductFromCart({
    required String userid,
    required String productId,
  }) async {
    final Uri url =
        Uri.parse('$baseUrl/api/cart/removeFromCart/$userid/$productId');
    final Map<String, dynamic> cartData = {
      'userid': userid,
      'productid': productId,
    };

    print(userid);
    print(productId);

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cartData),
      );

      if (response.statusCode == 200) {
        print('Product removed from cart successfully');
      } else {
        throw Exception('Failed to remove product from cart-');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Increase product quantity
  Future<void> increaseQuantity(String cartItemId) async {
    final Uri url = Uri.parse('$baseUrl/api/cart/increaseQuantity/$cartItemId');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Quantity increased successfully');
      } else {
        throw Exception('Failed to increase quantity');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Decrease product quantity
  Future<void> decreaseQuantity(String cartItemId) async {
    final Uri url = Uri.parse('$baseUrl/api/cart/decreaseQuantity/$cartItemId');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Quantity decreased successfully');
      } else {
        throw Exception('Failed to decrease quantity');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
