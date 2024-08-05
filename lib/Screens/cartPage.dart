import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/utils/colors.dart';

import '../services/auth_service.dart';
import '../view_model/cart_view_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    final authService = AuthServices();
    var id = await authService;
    print('-----------------------$id');
    final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    if (authService.userId != null) {
      cartProvider.fetchCartContents(authService.userId!, context);
    }
  }

  double calculateTotal() {
    final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    double total = 0.0;

    for (int index = 0; index < cartProvider.cartData.length; index++) {
      num price = cartProvider.cartData[index].price ?? 0.0;
      int quantity = cartProvider.cartItems[index].quantity ?? 0;
      total += price * quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();
    final authprovider = AuthServices();
    final total = calculateTotal();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColors, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Row(
          children: [
            SizedBox(width: 70),
            Text(
              'Cart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: cartprovider.cartData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                            cartprovider.cartData[index].image ?? 'image'),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  cartprovider.cartData[index].name ?? 'name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Size: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 0),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Qty:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  cartprovider.cartItems[index].quantity
                                      .toString(),
                                  style: TextStyle(fontSize: 17),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    cartprovider.decreaseQuantity(
                                        cartItemId:
                                            cartprovider.cartItems[index].sId!,
                                        context: context);
                                  },
                                  child: Icon(Icons.remove_circle,
                                      color: primaryColors),
                                ),
                                const SizedBox(width: 25),
                                InkWell(
                                  onTap: () {
                                    cartprovider.increaseQuantity(
                                        cartItemId:
                                            cartprovider.cartItems[index].sId!,
                                        context: context);
                                  },
                                  child: Icon(Icons.add_circle,
                                      color: primaryColors),
                                ),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  '\$: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ((cartprovider.cartData[index].price)! *
                                          (cartprovider
                                                  .cartItems[index].quantity)!
                                              .toInt())
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    print("hi");
                                    print(index);
                                    print(cartprovider.cartData[index].sId);
                                    cartprovider.removeProductFromCart(
                                        userid: authprovider.userId!,
                                        productId:
                                            cartprovider.cartData[index].sId!,
                                        context: context);

                                    setState(() {
                                      cartprovider.cartData.removeAt(index);
                                    });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 100,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      right: 10,
                      child: Container(
                        height: 60,
                        width: 130,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColors,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            // Navigate to checkout page
                            if (total == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: primaryColors,
                                  content: Text("Add items to Cart"),
                                ),
                              );
                            } else {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => PaymentDetails(
                              //       ChTotal: total,
                              //     ),
                              //   ),
                              // );
                            }
                          },
                          child: const Text(
                            "CheckOut>>",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 35,
                      left: 10,
                      child: Text(
                        "Total:",
                        style: TextStyle(
                          fontFamily: "Airbnb",
                          fontSize: 25,
                          color: primaryColors,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 90,
                      child: Text(
                        "₹${total.toStringAsFixed(1)}",
                        style: const TextStyle(
                          fontFamily: "Airbnb",
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
