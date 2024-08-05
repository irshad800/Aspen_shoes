import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Widgets/custom_item.dart';

import '../../model/product_model.dart';
import '../../view_model/product_view_mode.dart';
import '../details.dart';
import '../show_all_item_screen.dart';

class Adidas extends StatefulWidget {
  final String searchQuery;

  Adidas({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<Adidas> createState() => _NikeState();
}

class _NikeState extends State<Adidas> {
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
      MaterialPageRoute(
          builder: (context) => SeeAllFoodItemsScreen(
                category: 'Adidas',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) {
        print('Products in Nike widget: ${viewModel.products}');

        List<ProductModel> filteredFoodItems = viewModel.products
            .where((item) =>
                item.item == "Adidas" &&
                item.name != null &&
                item.name!
                    .toLowerCase()
                    .contains(widget.searchQuery.toLowerCase()))
            .toList()
            .reversed
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
            if (viewModel.loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: filteredFoodItems.length > 2
                      ? 2
                      : filteredFoodItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredFoodItems[index];
                    return custom_items(
                      id: item.sId,
                      image: item.image ?? '',
                      item: item.item,
                      name: item.name ?? '',
                      price: item.price,
                      index: index,
                      onTapFull: () {
                        print(item.item);
                      },
                      onTapadd: () {
                        print(item.item);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                                dImage: item.image ?? '',
                                dId: item.sId,
                                dName: item.name ?? '',
                                dPrice: (item.price ?? 0)),
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
