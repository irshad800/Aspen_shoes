import 'package:flutter/material.dart';

import '../services/order_services.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService _orderService = OrderService();

  Future<void> placeOrder({
    required String userId,
    required List<Map<String, dynamic>> products,
    required double totalAmount,
    required String address,
  }) async {
    try {
      final response = await _orderService.placeOrder(
        userId: userId,
        products: products,
        totalAmount: totalAmount,
        address: address,
      );
      // Handle the response (e.g., show a success message or handle errors)
      if (response['Success']) {
        // Order placed successfully
        // Notify listeners or update UI
      } else {
        // Handle error
        throw Exception(response['Message']);
      }
    } catch (error) {
      // Handle exception
      throw Exception('Failed to place order: $error');
    }
  }
}
