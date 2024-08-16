import 'package:flutter/material.dart';
import 'package:shoes/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Contact Us',
          style: TextStyle(color: Colors.white, fontFamily: "Airbnb"),
        ),
        backgroundColor: primaryColors,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Get in Touch',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any questions, feel free to reach out to us through the following methods:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('Email Us'),
              subtitle: Text('support@example.com'),
              onTap: () => _launchURL('mailto:support@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('Call Us'),
              subtitle: Text('+1 234 567 890'),
              onTap: () => _launchURL('tel:+1234567890'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text('Visit Us'),
              subtitle: Text('123 Business St, City, Country'),
              onTap: () => _launchURL(
                  'https://maps.google.com/?q=123+Business+St,+City,+Country'),
            ),
            SizedBox(height: 24),
            // Text(
            //   'Follow us on social media:',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.facebook),
            //       color: Colors.blue,
            //       onPressed: () => _launchURL('https://facebook.com/yourpage'),
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.),
            //       color: Colors.blue,
            //       onPressed: () => _launchURL('https://facebook.com/yourpage'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
