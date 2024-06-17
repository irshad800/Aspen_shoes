import 'package:flutter/material.dart';

import '../Widgets/custom_item.dart';
import 'details.dart';

class SeeAllFoodItemsScreen extends StatelessWidget {
  final List<Map<String, String>> foodItems;

  SeeAllFoodItemsScreen({Key? key, required this.foodItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug print to check the foodItems list
    print("Food items passed to SeeAllFoodItemsScreen: $foodItems");

    return Scaffold(
      appBar: AppBar(
        title: Text("S"),
      ),
      body: GridView.builder(
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
            image: item['image']!,
            name: item['name']!,
            time: item['time']!,
            rating: item['rating']!,
            price: item['price']!,
            onTapFull: () {},
            onTapadd: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(
                    dImage: item['image']!,
                    dName: item['name']!,
                    dCalorie: double.parse(item['rating']!),
                    dPrice: int.parse(item['price']!),
                    dRating: double.parse(item['rating']!),
                    dTime: int.parse(item['time']!),
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
