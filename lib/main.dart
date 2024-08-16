import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:shoes/Screens/home_screen.dart';
import 'package:shoes/Screens/splash_screens/splash.dart';
import 'package:shoes/provider/cart_provider.dart';
import 'package:shoes/provider/theme_view_model.dart';
import 'package:shoes/services/shared_preference.dart';
import 'package:shoes/utils/constants.dart';
import 'package:shoes/view_model/auth_view_model.dart';
import 'package:shoes/view_model/cart_view_model.dart';
import 'package:shoes/view_model/order_view_model.dart';
import 'package:shoes/view_model/product_view_mode.dart';
import 'package:shoes/view_model/wish_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? auth = await getSharedPreference();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Gemini.init(apiKey: GEMINI_API_KEY);

  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final bool? auth;

  MyApp({this.auth});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderViewModel(),
        ),
      ],
      child: MaterialApp(
        home: auth == true ? HomeScreen() : Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
