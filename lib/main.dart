import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Screens/home_screen.dart';
import 'package:shoes/provider/cart_provider.dart';
import 'package:shoes/services/shared_preference.dart';
import 'package:shoes/view_model/auth_view_model.dart';
import 'package:shoes/view_model/cart_view_model.dart';
import 'package:shoes/view_model/product_view_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? auth = await getSharedPreference();

  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final bool? auth;

  MyApp({this.auth});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ),
      ],
      child: MaterialApp(
        home: auth == true ? HomeScreen() : HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
