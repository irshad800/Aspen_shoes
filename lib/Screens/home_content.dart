import 'package:flutter/material.dart';
import 'package:shoes/Screens/sheo_items/adidas.dart';
import 'package:shoes/Screens/sheo_items/best_seller_page.dart';
import 'package:shoes/Screens/sheo_items/converse.dart';
import 'package:shoes/Screens/sheo_items/nike.dart';
import 'package:shoes/Screens/sheo_items/puma.dart';
import 'package:shoes/Screens/sheo_items/under_armour.dart';

import '../utils/colors.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HeaderPartState();
}

class _HeaderPartState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  late TabController _tabController;
  int _selectedTabIndex = 0;

  List<Map<String, String>> ite = [
    {"name": " Nike ", "icon": "assets/images/Group 6.png"},
    {"name": " Puma ", "icon": "assets/images/Frame 8.png"},
    {"name": " Under Armour ", "icon": "assets/images/Group 14.png"},
    {"name": " Adidas ", "icon": "assets/images/Group 18.png"},
    {"name": " Converse ", "icon": "assets/images/Frame 11 (1).png"}
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ite.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  void clearSearchQuery() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: ite.length,
        child: WillPopScope(
            onWillPop: () async {
              if (_searchQuery.isNotEmpty) {
                clearSearchQuery();
                return false;
              }
              return true;
            },
            child: Container(
              color: Colors.white60,
              child: Column(children: [
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            child: Image.asset("assets/images/apps-circle.png"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "  Store location",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: primaryColors,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Calicut,KL",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => UserProfileScreen()));
                        },
                        child: CircleAvatar(
                          radius: 21, // Adjust the radius as needed
                          backgroundImage:
                              const AssetImage("assets/images/Group 27@2x.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: primaryColors,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Airbnb"),
                    tabs: ite.asMap().entries.map((entry) {
                      int idx = entry.key;
                      var item = entry.value;
                      return Tab(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                          child: Row(
                            children: [
                              Image.asset(item['icon']!, height: 30, width: 30),
                              SizedBox(width: 3),
                              if (_selectedTabIndex == idx) Text(item['name']!),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    indicatorPadding: const EdgeInsets.only(left: 0),
                    tabAlignment: TabAlignment.start,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Nike(
                              searchQuery: _searchQuery,
                            ),
                            Puma(
                              searchQuery: _searchQuery,
                            ),
                            UnderArmour(
                              searchQuery: _searchQuery,
                            ),
                            Adidas(
                              searchQuery: _searchQuery,
                            ),
                            Converse(
                              searchQuery: _searchQuery,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ite.length,
                          itemBuilder: (context, index) {
                            return BestSeller(
                              searchQuery: _searchQuery,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
