import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class custom_items extends StatefulWidget {
  const custom_items({
    Key? key,
    this.image,
    this.name,
    this.time,
    this.rating,
    this.price,
    this.onTapFull,
    this.onTapadd,
    this.index,
  }) : super(key: key);

  final String? image;
  final String? name;
  final String? time;
  final String? rating;
  final String? price;
  final VoidCallback? onTapFull;
  final VoidCallback? onTapadd;
  final int? index;

  @override
  State<custom_items> createState() => _ItemsState();
}

class _ItemsState extends State<custom_items> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: primaryColors,
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: _scaffoldKey,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey[300],
        ),
        height: 220,
        width: 158,
        child: Stack(
          children: [
            Positioned(
              top: 9,
              left: 15,
              child: Container(
                height: 120,
                width: 130,
                child: Image.asset(
                  widget.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 63,
              left: 10,
              right: 15,
              child: Center(
                child: Text(
                  widget.name!,
                  style: TextStyle(fontFamily: "Airbnb"),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 10,
              child: Text(
                " \$${widget.price}",
                style: TextStyle(fontSize: 21, fontFamily: "Airbnb"),
              ),
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: GestureDetector(
                onTap: widget.onTapadd,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: primaryColors,
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
