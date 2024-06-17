import 'package:flutter/material.dart';

import '../Screens/home_screen.dart';
import '../utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColors,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: primaryColors,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: primaryColors,
            ),
            title: Text('Settings'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => UserProfileScreen(),
              //     )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: primaryColors,
            ),
            title: Text('Profile'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => UserProfileScreen(),
              //     )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: primaryColors,
            ),
            title: Text('Share App'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => UserProfileScreen(),
              //     )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: primaryColors,
            ),
            title: Text('Help'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => UserProfileScreen(),
              //     )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: primaryColors,
            ),
            title: Text('Contact'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Contact(),
              //     )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: primaryColors,
            ),
            title: Text('LogOut'),
            onTap: () async {},
          ),
          // Add more ListTiles here for more options
        ],
      ),
    );
  }
}
