import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoes/Screens/splash_screens/splash2.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _splashState();
}

class _splashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => splash2(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          // Swiped up
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => splash2()),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/WhatsApp Image 2024-06-01 at 11.28.52_671046dd.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 420,
            left: 110,
            child: Text(
              'WALK WAY',
              style: TextStyle(
                  fontFamily: 'Airbnb',
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ));
  }
}
