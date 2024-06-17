import 'package:flutter/material.dart';

import '../utils/cart_list.dart'; // Assuming this contains your cart items list
import '../utils/colors.dart';
import 'check_out.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: primaryColors,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              // Calculate total price
              num totalPrice = calculateTotalPrice();

              // Navigate to CheckoutPage and pass total amount
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
      body: Citems.isEmpty
          ? Center(
              child: Text('Your cart is empty!'),
            )
          : ListView.builder(
              itemCount: Citems.length,
              itemBuilder: (context, index) {
                final item = Citems[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: item['image'] != null
                        ? Image.asset(
                            item['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image),
                    title: Text(item['name'] ?? ''),
                    subtitle: Text(
                        'Price: ₹${item['price']} | Quantity: ${item['qty']}'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: primaryColors,
                      ),
                      onPressed: () {
                        setState(() {
                          delete(index: index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Citems.isEmpty ? null : _buildTotalSection(),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      color: primaryColors,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Items: ${Citems.length}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Total Price: ₹${calculateTotalPrice()}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  num calculateTotalPrice() {
    num totalPrice = 0;
    Citems.forEach((item) {
      totalPrice += (item['price'] ?? 0) * (item['qty'] ?? 0);
    });
    return totalPrice;
  }
}
