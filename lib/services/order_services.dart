import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoes/utils/constants.dart';

class OrderService {
  final String apiUrl = "$baseUrl/api/order/createOrder";

  Future<Map<String, dynamic>> placeOrder({
    required String userId,
    required List<Map<String, dynamic>> products,
    required double totalAmount,
    required String address,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/createOrder'), // Corrected URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userid': userId,
        'products': products,
        'totalAmount': totalAmount,
        'address': address,
      }),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to place order');
    }
  }
}
