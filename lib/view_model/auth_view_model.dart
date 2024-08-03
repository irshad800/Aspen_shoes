import 'package:flutter/material.dart';
import 'package:shoes/Screens/auth/login_page.dart';
import 'package:shoes/Screens/home_screen.dart';
import 'package:shoes/services/auth_service.dart';

import '../model/auth_model.dart';

class AuthViewModel extends ChangeNotifier {
  bool loading = false;
  final _authservice = AuthServices();

  Future<void> Registration(
      {required Authmodel user, required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();
      await _authservice.register(user: user);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();
      await _authservice.login(username: username, password: password);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }
}
