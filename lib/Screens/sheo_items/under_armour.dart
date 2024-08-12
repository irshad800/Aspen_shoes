import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Widgets/custom_item.dart';

import '../../model/product_model.dart';
import '../../view_model/product_view_mode.dart';
import '../details.dart';
import '../show_all_item_screen.dart';

class UnderArmour extends StatefulWidget {
  final String searchQuery;

  UnderArmour({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<UnderArmour> createState() => _NikeState();
}

class _NikeState extends State<UnderArmour> {
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
                category: 'Under Armour',
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
                item.item == "Under Armour" &&
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
                  itemCount: filteredFoodItems.length,
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
          ],
        );
      },
    );
  }
}
