import 'package:shoes/model/product_model.dart';

class CartModel {
  final String userId;
  final ProductModel product;
  final int quantity;

  CartModel({
    required this.userId,
    required this.product,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['userId'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
