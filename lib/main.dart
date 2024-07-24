import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Screens/home_screen.dart';
import 'package:shoes/provider/cart_provider.dart';
import 'package:shoes/view_model/auth_view_model.dart';
import 'package:shoes/view_model/product_view_mode.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      )));
}
