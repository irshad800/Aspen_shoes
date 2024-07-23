import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  num get totalPrice {
    num total = 0;
    _items.forEach((item) {
      total += (item['price'] ?? 0) * (item['qty'] ?? 0);
    });
    return total;
  }
}
