import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Screens/wish_page.dart';

import '../Widgets/custom_drawer.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart';
import '../view_model/cart_view_model.dart';
import 'cartPage.dart';
import 'chat_bot_screen.dart';
import 'home_content.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Define the list of widgets to display for each tab
  static List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ChatBotScreen(),
    CartScreen(),
    NotificationScreen(),
    WishScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartViewModel>();
    final authProvider = AuthServices();
    int notificationCount = cartProvider.cartItems.length;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          toolbarHeight: 0,
        ),
        drawer: CustomDrawer(),
        body: _widgetOptions[_selectedIndex],
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          elevation: 5,
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 35,
          ),
          backgroundColor: primaryColors,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0, // Adjust this value to align the FAB correctly
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _onItemTapped(0),
                icon: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? primaryColors : Colors.grey,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () => _onItemTapped(1),
                icon: Icon(
                  Icons.chat,
                  color: _selectedIndex == 1 ? primaryColors : Colors.grey,
                  size: 30,
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () => _onItemTapped(3),
                    icon: Icon(
                      Icons.notifications,
                      color: _selectedIndex == 3 ? primaryColors : Colors.grey,
                      size: 30,
                    ),
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            '$notificationCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                onPressed: () => _onItemTapped(4),
                icon: Icon(
                  Icons.favorite,
                  color: _selectedIndex == 4 ? primaryColors : Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
