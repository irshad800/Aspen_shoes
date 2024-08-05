import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/utils/colors.dart';

import '../services/auth_service.dart';
import '../view_model/wish_view_model.dart';

class WishScreen extends StatefulWidget {
  const WishScreen({super.key});

  @override
  State<WishScreen> createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {
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
    final wishProvider = Provider.of<WishViewModel>(context, listen: false);
    if (authService.userId != null) {
      wishProvider.fetchWishContents(authService.userId!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wishProvider = context.watch<WishViewModel>();
    final authProvider = AuthServices();

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
            SizedBox(width: 50),
            Text(
              'WishList',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: wishProvider.wishData.length,
        itemBuilder: (context, index) {
          final product = wishProvider.wishData[index];
          final wishItem = wishProvider.wishItems[index];

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
                    child: Image.network(product.image ??
                        'image'), // Use a placeholder if the image is null
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
                              product.name ??
                                  'Product name', // Default text if name is null
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
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
                              ((product.price ?? 0) * (wishItem.quantity ?? 1))
                                  .toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                print("hi");
                                print(index);
                                print(product.sId);
                                wishProvider.removeProductFromWish(
                                    userid: authProvider.userId!,
                                    productId: product.sId!,
                                    context: context);

                                setState(() {
                                  wishProvider.wishData.removeAt(index);
                                });
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
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
    );
  }
}
