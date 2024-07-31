import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/cart_view_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: cartViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : cartViewModel.carts.isEmpty
              ? Center(child: Text("Your cart is empty"))
              : ListView.builder(
                  itemCount: cartViewModel.carts.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartViewModel.carts[index];
                    return ListTile(
                      leading: Image.network(cartItem.product.image ?? ''),
                      title: Text(cartItem.product.name ?? ''),
                      // subtitle: Text('Quantity: ${cartItem.quantity}'),
                      trailing: Text('\$${cartItem.product.price}'),
                    );
                  },
                ),
    );
  }
}
