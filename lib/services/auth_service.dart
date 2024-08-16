import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_model.dart';
import '../utils/constants.dart';

class AuthServices {
  String? userId;

  AuthServices() {
    _loadUserId();
  }

  // Load user ID from SharedPreferences
  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print('Loaded user ID: $userId');
  }

  // Save user ID to SharedPreferences
  Future<void> _saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
    userId = id;
    print('Saved user ID: $userId');
  }

  // Register a new user
  Future<void> register({required Authmodel user}) async {
    final Uri url = Uri.parse('$baseUrl/api/auth/register');
    try {
      final response = await http.post(url, body: user.toJson());

      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        print('Failed to register. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
      throw Exception('An error occurred during registration');
    }
  }

  // Login user and save user ID
  Future<void> login(
      {required String username, required String password}) async {
    final Uri url = Uri.parse('$baseUrl/api/auth/login');
    try {
      final Map<String, dynamic> body = {
        'username': username,
        'password': password,
      };
      print("Request body: $body");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        print('User ID from response: ${responseData['_id']}');
        print('Username from response: ${responseData['username']}');
        print('Email from response: ${responseData['email']}');

        userId = responseData['loginid'];
        if (userId != null) {
          await _saveUserId(userId!);
          print('Login successful');
          print('User ID: $userId');
        } else {
          print('User ID is null');
          throw Exception('User ID not found in response');
        }
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('An error occurred during login');
    }
  }

  // Logout user and clear stored user ID
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    userId = null;
    print('User logged out and ID cleared');
  }

  // Check if user is already logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userId');
  }
}
