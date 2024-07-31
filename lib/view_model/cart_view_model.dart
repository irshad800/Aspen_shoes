import 'package:flutter/cupertino.dart';

import '../model/cart_model.dart';
import '../services/cart_services.dart';

class CartViewModel extends ChangeNotifier {
  bool loading = false;
  List<CartModel> carts = [];

  final _cartService = CartServices();

  Future<void> fetchProducts() async {
    loading = true;
    notifyListeners();

    try {
      carts = await _cartService.getCart();
      loading = false;
    } catch (e) {
      loading = false;
      print('An error occurred: $e');
    }
    notifyListeners();
  }
}
