import 'package:flutter/material.dart';
import 'package:shoes/model/product_model.dart';
import 'package:shoes/services/product_services.dart';

class ProductViewModel extends ChangeNotifier {
  bool loading = false;
  List<ProductModel> products = [];

  final _productService = ProductServices();

  Future<void> fetchProducts() async {
    loading = true;
    notifyListeners();

    try {
      products = await _productService.getProducts();
      print(products);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print('An error occurred: $e');
    }
  }
}
