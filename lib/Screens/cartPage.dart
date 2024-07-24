import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../utils/colors.dart';
import 'check_out.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: primaryColors,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              final num totalPrice = cartProvider.totalPrice;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(total: totalPrice),
                ),
              );
            },
            child: Text(
              'Checkout',
              style: TextStyle(color: primaryColors),
            ),
          ),
        ],
      ),
      body: cartProvider.items.isEmpty
          ? const Center(
              child: Text('Your cart is empty!'),
            )
          : ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: item['image'] != null
                        ? Image.network(
                            item['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image),
                    title: Text(item['name'] ?? 'Unnamed Item'),
                    subtitle: Text(
                        'Price: ₹${item['price']} | Quantity: ${item['qty']}'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: primaryColors,
                      ),
                      onPressed: () {
                        cartProvider.removeItem(index);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar:
          cartProvider.items.isEmpty ? null : _buildTotalSection(cartProvider),
    );
  }

  Widget _buildTotalSection(CartProvider cartProvider) {
    return Container(
      color: primaryColors,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Items: ${cartProvider.items.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Total Price: ₹${cartProvider.totalPrice}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
