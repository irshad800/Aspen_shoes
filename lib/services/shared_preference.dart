import 'package:shared_preferences/shared_preferences.dart';

Future<void> shared() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('repeat', true);
}

Future<bool?> getSharedPreference() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? auth2 = prefs.getBool('repeat');
  return auth2;
}

Future<void> logoutShared() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('repeat');
}
