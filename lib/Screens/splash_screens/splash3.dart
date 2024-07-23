import 'package:flutter/material.dart';

class splash1_3 extends StatefulWidget {
  splash1_3({super.key, required this.image, this.roundimage});
  String image;
  Widget? roundimage;

  @override
  State<splash1_3> createState() => _splash1_3State();
}

class _splash1_3State extends State<splash1_3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/Ellipse 906.png',
            ),
          ),
          // Background image
          Positioned(
            top: 70,
            left: 40,
            bottom: 280,
            right: 50,
            child: Image.asset(
              'assets/images/NIKE.png',
            ),
          ),
          Positioned(
            top: 120,
            left: 50,
            right: 20,
            child: Image.asset(
              widget.image,
            ),
          ),
          if (widget.roundimage != null)
            Positioned(
              top: 230,
              right: 10,
              child: widget.roundimage!,
            ),

          Positioned(
            top: 100,
            left: 0,
            right: 10,
            bottom: 280,
            child: Image.asset(
              'assets/images/Group 284.png',
            ),
          ),
          Positioned(
            bottom: 160,
            left: 15,
            right: 10,
            child: Text(
              'Start journey \nWith nike',
              style: TextStyle(fontSize: 40),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 15,
            child: Text(
              'Smart, Gorgeous & Fashionable\nCollection',
              style: TextStyle(fontSize: 20, color: Color(0xFF707B81)),
            ),
          ),
        ],
      ),
    );
  }
}
