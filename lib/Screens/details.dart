import 'package:flutter/material.dart';

import '../utils/cart_list.dart';
import '../utils/colors.dart';

class Details extends StatefulWidget {
  const Details(
      {super.key,
      this.dImage,
      this.dName,
      this.dRating,
      this.dCalorie,
      this.dTime,
      this.DText,
      this.dPrice});
  final String? dImage;
  final String? dName;
  final int? dPrice;
  final double? dRating;
  final double? dCalorie;
  final int? dTime;
  final String? DText;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _showSnackBar() {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: primaryColors,
        content: Text('Added to Cart'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  int _counter = 1;
  int _totalPrice = 0;
  @override
  void initState() {
    _totalPrice = widget.dPrice ?? 0;
    super.initState();
  }

  void increment() {
    setState(() {
      _counter++;
      _totalPrice = (widget.dPrice ?? 0) * _counter;
    });
  }

  void decrement() {
    setState(() {
      if (_counter < 2) {
        _counter = 1;
      } else {
        _counter--;
        _totalPrice = (widget.dPrice ?? 0) * _counter;
      }
    });
  }

  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  bool _expanded = false;
  void _toggleReadMore() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void addToCart() {
    Crt(
      favImage: widget.dImage,
      favName: widget.dName,
      qty: _counter,
      favPrice: widget.dPrice,
    );
    _showSnackBar();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String text =
        "We recommend making this avocado salad just before you plan to serve it, as the avocados will brown slightly over time and the ingredients will become liquidy. This avocado salad is a delicious combination of ripe avocados, sweet onions, fresh tomatoes, and cilantro. This recipe is so easy to make and very colorful — I think you'll like it!";
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      body: Container(
        color: primaryColors,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 134,
              child: Text(
                "Details",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Airbnb",
                  color: Colors.white70,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              top: 290,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                height: 120,
                width: 130,
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 77,
              left: 20,
              right: 20,
              child: widget.dImage != null
                  ? Hero(
                      tag: widget.dImage!,
                      child: Image.asset(
                        widget.dImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                      ),
                    )
                  : Container(),
            ),
            Positioned(
              top: 137,
              left: 20,
              right: 20,
              child: widget.dImage != null
                  ? Hero(
                      tag: widget.dImage!,
                      child: Image.asset(
                        "assets/images/Group 136.png",
                        width: double.infinity,
                        height: 300,
                      ),
                    )
                  : Container(),
            ),
            Positioned(
                top: 350,
                left: 20,
                child: Column(
                  children: [
                    Text(
                      "Best seller",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      widget.dName ?? "",
                      style: TextStyle(fontFamily: "Airbnb", fontSize: 30),
                    ),
                  ],
                )),
            Positioned(
                top: 455,
                left: 20,
                child: Text(
                  "₹$_totalPrice",
                  style: TextStyle(
                      fontFamily: "Airbnb", fontSize: 25, color: primaryColors),
                )),
            Positioned(
                bottom: 180,
                left: 25,
                child: Text(
                  "About Food",
                  style: TextStyle(fontFamily: "Airbnb", fontSize: 20),
                )),
            Positioned(
              top: 572,
              bottom: 80,
              left: 18,
              child: SingleChildScrollView(
                child: Container(
                  width: 310, // Adjust width as per your design
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _expanded
                          ? Text(
                              text,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              text,
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: _toggleReadMore,
                        child: Text(
                          _expanded ? 'Read Less' : 'Read More',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 55,
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColors,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      addToCart();
                    },
                    child: Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
