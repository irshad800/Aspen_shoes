import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../provider/cart_provider.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart';
import '../view_model/cart_view_model.dart';
import 'cartPage.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    this.dImage,
    this.dName,
    this.dRating,
    this.dCalorie,
    this.dTime,
    this.DText,
    this.dPrice,
    this.dId,
  }) : super(key: key);

  final String? dImage;
  final String? dName;
  final int? dPrice;
  final double? dRating;
  final double? dCalorie;
  final int? dTime;
  final String? DText;
  final String? dId;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _counter = 1;
  int _totalPrice = 0;
  bool _isFavorite = false;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _totalPrice = widget.dPrice ?? 0;
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: primaryColors,
        content: const Text('Added to Cart'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _totalPrice = (widget.dPrice ?? 0) * _counter;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        _totalPrice = (widget.dPrice ?? 0) * _counter;
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _toggleReadMore() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void _addToCart() {
    addItemToCart(
      favImage: widget.dImage,
      favName: widget.dName,
      qty: _counter,
      favPrice: widget.dPrice,
      context: context,
    );
    _showSnackBar();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();
    final authservise = AuthServices();
    final String text =
        "We recommend making this Nike just before you plan to serve it, as the avocados will brown slightly over time and the ingredients will become liquidy. This avocado salad is a delicious combination of ripe avocados, sweet onions, fresh tomatoes, and cilantro. This recipe is so easy to make and very colorful — I think you'll like it!";

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: 120,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: _toggleFavorite,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.white70,
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
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 77,
              left: 20,
              right: 20,
              child: ClipOval(
                child: widget.dImage != null
                    ? Hero(
                        tag: widget.dImage!,
                        child: Image.network(
                          widget.dImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                        ),
                      )
                    : Container(),
              ),
            ),
            // Positioned(
            //   top: 137,
            //   left: 20,
            //   right: 20,
            //   child: widget.dImage != null
            //       ? Hero(
            //           tag: widget.dImage!,
            //           child: Image.network(""
            //               // "assets/images/Group 136.png",
            //               //  width: double.infinity,
            //               //  height: 300,
            //               ),
            //         )
            //       : Container(),
            // ),
            Positioned(
              top: 350,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Best seller",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    widget.dName ?? "",
                    style: const TextStyle(
                      fontFamily: "Airbnb",
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 455,
              left: 20,
              child: Text(
                "₹$_totalPrice",
                style: TextStyle(
                  fontFamily: "Airbnb",
                  fontSize: 25,
                  color: primaryColors,
                ),
              ),
            ),
            Positioned(
              bottom: 230,
              left: 25,
              child: const Text(
                "About Shoes",
                style: TextStyle(
                  fontFamily: "Airbnb",
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 552,
              bottom: 80,
              left: 18,
              child: SingleChildScrollView(
                child: Container(
                  width: 310,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _expanded
                          ? Text(
                              text,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              text,
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _toggleReadMore,
                        child: Text(
                          _expanded ? 'Read Less' : 'Read More',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
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
                margin: const EdgeInsets.all(20),
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    {
                      print(authservise.userId);
                      ProductModel newproduct = ProductModel(
                          name: widget.dName,
                          image: widget.dImage,
                          price: widget.dPrice,
                          sId: widget.dId);

                      cartprovider.addProductToCart(
                          userid: authservise.userId!,
                          product: newproduct,
                          context: context);
                    }
                    ;
                  },
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
