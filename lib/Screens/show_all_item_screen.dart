import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/custom_item.dart';
import '../view_model/product_view_mode.dart';
import 'details.dart';

class SeeAllFoodItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final foodItems = productViewModel.products;

    print("Food items passed to SeeAllFoodItemsScreen: $foodItems");

    return Scaffold(
      appBar: AppBar(
        title: Text("NIkE"),
      ),
      body: productViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
                childAspectRatio: 0.82,
              ),
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final item = foodItems[index];
                return custom_items(
                  image: item.image,
                  name: item.name,
                  // time: item.time.toString(),
                  // rating: item.rating.toString(),
                  price: item.price.toString(),
                  onTapFull: () {},
                  onTapadd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          dImage: item.image,
                          dName: item.name,
                          // dCalorie: item.calorie,
                          dPrice: item.price,
                          // dRating: item.rating,
                          // dTime: item.time,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
