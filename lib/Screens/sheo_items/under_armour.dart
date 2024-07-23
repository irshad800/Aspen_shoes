import 'package:flutter/material.dart';
import 'package:shoes/Widgets/custom_item.dart';

import '../details.dart';
import '../show_all_item_screen.dart';

class UnderArmour extends StatefulWidget {
  final String searchQuery;
  final Function(Map<String, String>) onToggleFavorite;

  UnderArmour(
      {Key? key, required this.searchQuery, required this.onToggleFavorite})
      : super(key: key);

  @override
  State<UnderArmour> createState() => _FoodState();
}

class _FoodState extends State<UnderArmour> {
  final List<Map<String, String>> foodItems = [
    {
      "image":
          "assets/images/nike-zoom-winflo-3-831561-001-mens-running-shoes-11550187236tiyyje6l87_prev_ui 1.png",
      "name": "Nike AirMax",
      "time": "30",
      "rating": "5.0",
      "price": "150",
    },
    {
      "image": "assets/images/Frame 250.png",
      "name": "Nike Jordan",
      "time": "20",
      "rating": "4.5",
      "price": "120",
    },
    {
      "image":
          "assets/images/nike-zoom-winflo-3-831561-001-mens-running-shoes-11550187236tiyyje6l87_prev_ui 1.png",
      "name": "Nike AirMax",
      "time": "20",
      "rating": "4.5",
      "price": "12",
    },
    {
      "image":
          "assets/images/nike-zoom-winflo-3-831561-001-mens-running-shoes-11550187236tiyyje6l87_prev_ui 1.png",
      "name": "Nike AirMax",
      "time": "25",
      "rating": "4.5",
      "price": "160",
    },
  ];

  void navigateToSeeAll() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeeAllFoodItemsScreen(
          foodItems: foodItems.toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredFoodItems = foodItems
        .where((item) => item['name']!
            .toLowerCase()
            .contains(widget.searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "    Popular Shoes",
              style: TextStyle(fontFamily: "Airbnb"),
            ),
            GestureDetector(
              onTap: navigateToSeeAll,
              child: Text(
                "see all     ",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
              childAspectRatio: 0.82,
            ),
            itemCount:
                filteredFoodItems.length > 2 ? 2 : filteredFoodItems.length,
            itemBuilder: (context, index) {
              final item = filteredFoodItems[index];
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
        ),
      ],
    );
  }
}
