import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Screens/splash_screens/splash.dart';
import 'package:shoes/provider/cart_provider.dart';
import 'package:shoes/view_model/auth_view_model.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
      )));
}
