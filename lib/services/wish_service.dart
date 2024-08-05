import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../model/wish_model.dart';
import '../utils/constants.dart';

class WishService {
  Future<void> addProductToWish({
    required String userid,
    required ProductModel product,
  }) async {
    final Uri url = Uri.parse('$baseUrl/api/wish/addToWish');

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
        throw Exception('Failed to add product to Wishlist');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<WishModel>> getWishContents(String userid) async {
    final Uri url = Uri.parse('$baseUrl/api/wish/viewWish/$userid');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        if (data['data'] is List) {
          var WishList = (data['data'] as List)
              .map((item) => WishModel.fromJson(item as Map<String, dynamic>))
              .toList();
          print('Wishlist: $WishList');

          return WishList;
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
  Future<void> removeProductFromWish({
    required String userid,
    required String productId,
  }) async {
    final Uri url =
        Uri.parse('$baseUrl/api/cart/removeFromWish/$userid/$productId');
    final Map<String, dynamic> wishData = {
      'userid': userid,
      'productid': productId,
    };

    print(userid);
    print(productId);

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(wishData),
      );

      if (response.statusCode == 200) {
        print('Product removed from cart successfully');
      } else {
        throw Exception('Failed to remove product from wish-');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
