import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/custom_item.dart';
import '../utils/colors.dart';
import '../view_model/product_view_mode.dart';
import 'details.dart';

class SeeAllFoodItemsScreen extends StatefulWidget {
  @override
  State<SeeAllFoodItemsScreen> createState() => _SeeAllFoodItemsScreenState();
}

class _SeeAllFoodItemsScreenState extends State<SeeAllFoodItemsScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  void clearSearchQuery() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final foodItems = productViewModel.products;

    print("Food items passed to SeeAllFoodItemsScreen: $foodItems");

    final filteredFoodItems = foodItems
        .where((item) {
          final itemName = item.name?.toLowerCase() ?? '';
          final searchQuery = _searchQuery.toLowerCase();
          return itemName.contains(searchQuery);
        })
        .toList()
        .reversed
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("NIKE"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: primaryColors)),
                hintText: "Looking for shoes",
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          WillPopScope(
            onWillPop: () async {
              if (_searchQuery.isNotEmpty) {
                clearSearchQuery();
                return false;
              }
              return true;
            },
            child: productViewModel.loading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
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
                          image: item.image,
                          name: item.name,
                          price: item.price.toString(),
                          onTapFull: () {},
                          onTapadd: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(
                                  dImage: item.image,
                                  dName: item.name,
                                  dPrice: item.price,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
