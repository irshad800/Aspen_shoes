import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/utils/colors.dart';

import '../services/auth_service.dart';
import '../view_model/cart_view_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<NotificationScreen> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    final authService = AuthServices();
    var id = await authService.userId; // Wait for userId to load
    print('-----------------------$id');
    final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    if (authService.userId != null) {
      cartProvider.fetchCartContents(authService.userId!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();
    final authprovider = AuthServices();

    double totalAmount = 0;
    for (int i = 0; i < cartprovider.cartData.length; i++) {
      totalAmount += (cartprovider.cartData[i].price ?? 0) *
          (cartprovider.cartItems[i].quantity ?? 0);
    }

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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _loadDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (cartprovider.cartData.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    SizedBox(height: 10),
                    Text('Cart is empty'),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Container(
                    height: 670,
                    child: ListView.builder(
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
                                      cartprovider.cartData[index].image ??
                                          'image'),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            cartprovider.cartData[index].name ??
                                                'name',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          // Text(
                                          //   'Size: ',
                                          //   style: TextStyle(
                                          //     fontSize: 18,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                          // SizedBox(width: 0),
                                          // Text(
                                          //   cartprovider.cartData[index].size
                                          //       .toString(),
                                          //   style: TextStyle(fontSize: 17),
                                          // ),
                                          SizedBox(width: 10),
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
                                            cartprovider
                                                .cartItems[index].quantity
                                                .toString(),
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(width: 20),
                                          const Text(
                                            '₹: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ((cartprovider.cartData[index]
                                                        .price)! *
                                                    (cartprovider
                                                            .cartItems[index]
                                                            .quantity)!
                                                        .toInt())
                                                .toString(),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          const Spacer(),
                                          // InkWell(
                                          //   onTap: () {
                                          //     cartprovider.decreaseQuantity(
                                          //         cartItemId: cartprovider
                                          //             .cartItems[index].sId!,
                                          //         context: context);
                                          //   },
                                          //   child: Icon(Icons.remove_circle,
                                          //       color: primaryColors),
                                          // ),
                                          const SizedBox(width: 25),
                                          // InkWell(
                                          //   onTap: () {
                                          //     cartprovider.increaseQuantity(
                                          //         cartItemId: cartprovider
                                          //             .cartItems[index].sId!,
                                          //         context: context);
                                          //   },
                                          //   child: Icon(Icons.add_circle,
                                          //       color: primaryColors),
                                          // ),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Status: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            cartprovider
                                                    .cartItems[index].status ??
                                                'status..',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: primaryColors),
                                          ),
                                          const Spacer(),
                                          // InkWell(
                                          //   onTap: () {
                                          //     print(index);
                                          //     print(cartprovider
                                          //         .cartData[index].sId);
                                          //     cartprovider.removeProductFromCart(
                                          //         userid: authprovider.userId!,
                                          //         productId: cartprovider
                                          //             .cartData[index].sId!,
                                          //         context: context);
                                          //     setState(() {
                                          //       cartprovider.cartData
                                          //           .removeAt(index);
                                          //     });
                                          //   },
                                          //   child: const Icon(Icons.delete,
                                          //       color: Colors.red),
                                          // ),
                                          const SizedBox(width: 5),
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
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
