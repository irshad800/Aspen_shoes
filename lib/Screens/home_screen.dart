import 'package:flutter/material.dart';
import 'package:shoes/Screens/wish_page.dart';

import '../Widgets/custom_drawer.dart';
import '../utils/colors.dart';
import 'cartPage.dart';
import 'chat_bot_screen.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ChatBotScreen(),
    CartScreen(),
    Container(),
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
        body: _widgetOptions.elementAt(_selectedIndex),
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 7.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                  onPressed: () => _onItemTapped(0),
                  icon: Icon(
                    Icons.home,
                    color: _selectedIndex == 0 ? primaryColors : Colors.grey,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () => _onItemTapped(1),
                  icon: Icon(
                    Icons.chat,
                    color: _selectedIndex == 1 ? primaryColors : Colors.grey,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () => _onItemTapped(3),
                  icon: Icon(
                    Icons.notifications,
                    color: _selectedIndex == 3 ? primaryColors : Colors.grey,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () => _onItemTapped(4),
                  icon: Icon(
                    Icons.favorite,
                    color: _selectedIndex == 4 ? primaryColors : Colors.grey,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
