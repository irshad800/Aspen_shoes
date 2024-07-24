import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void updateItem(int index, Map<String, dynamic> updatedItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = updatedItem;
      notifyListeners();
    }
  }

  num get totalPrice {
    num total = 0;
    _items.forEach((item) {
      total += (item['price'] ?? 0) * (item['qty'] ?? 0);
    });
    return total;
  }
}

void addItemToCart({
  required BuildContext context,
  String? favName,
  String? favImage,
  int? favPrice,
  int? qty,
  int? index,
}) {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);

  Map<String, dynamic> cartItem = {
    "name": favName,
    "image": favImage,
    "price": favPrice,
    "qty": qty,
    "index": index
  };

  cartProvider.addItem(cartItem);
}

void removeItemFromCart({required BuildContext context, required int index}) {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  cartProvider.removeItem(index);
}
