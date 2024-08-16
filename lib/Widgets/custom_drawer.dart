import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shoes/Screens/chat_bot_screen.dart';

import '../Screens/home_screen.dart';
import '../Screens/profile.dart';
import '../Screens/splash_screens/contact_page.dart';
import '../provider/theme_view_model.dart';
import '../utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeViewModel>(context);

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(),
                  )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: primaryColors,
            ),
            title: Text('Share App'),
            onTap: () {
              String appLink =
                  'https://drive.google.com/file/d/1S6x2aFBBdkMMRbF47hhZTc4GX50WluB8/view?usp=drive_link';

              Share.share('Check out this amazing app: $appLink');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: primaryColors,
            ),
            title: Text('Help'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBotScreen(),
                  )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: primaryColors,
            ),
            title: Text('Contact'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactPage(),
                  )); // Closes the drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.nightlight_round,
              color: primaryColors,
            ),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          Divider(),
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
