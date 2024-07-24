import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Widgets/custom_item.dart';

import '../../model/product_model.dart';
import '../../view_model/product_view_mode.dart';
import '../details.dart';
import '../show_all_item_screen.dart';

class Food extends StatefulWidget {
  final String searchQuery;

  Food({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  void navigateToSeeAll() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeeAllFoodItemsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.loading) {
          return Center(child: CircularProgressIndicator());
        }

        print('Products in Food widget: ${viewModel.products}');

        List<ProductModel> filteredFoodItems = viewModel.products
            .where((item) =>
                item.name != null &&
                item.name!
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
            SizedBox(height: 10),
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
                    image: item.image ?? '',
                    name: item.item ?? '',
                    price: (item.price ?? 0).toString(),
                    index: index,
                    onTapFull: () {},
                    onTapadd: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                              dImage: item.image ?? '',
                              dName: item.name ?? '',
                              // dCalorie: double.parse(item.rating ?? '0'),
                              dPrice: (item.price ?? 0)

                              // dRating: double.parse(item.rating ?? '0'),
                              // dTime: int.parse(item.time ?? '0'),
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "    New Arrivals",
                  style: TextStyle(fontFamily: "Airbnb"),
                ),
                GestureDetector(
                  child: const Text(
                    "see all     ",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
