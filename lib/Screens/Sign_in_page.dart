import 'package:flutter/material.dart';
import 'package:shoes/Widgets/Custom_textfeild.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(); // Add navigation functionality if needed
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            // Add some spacing if needed
          ],
        ),
        backgroundColor:
            Color(0xFFF8F9FA), // Set the background color of the AppBar
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xFFF8F9FA),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),

                  // Welcome Text
                  Text(
                    'Create Account',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Airbnb"),
                  ),
                  Text(
                    "Lets Create Account Together",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: 30),

                  // Email Address
                  custom_textfeild(
                    labeltext: 'Your Name',
                  ),

                  SizedBox(height: 20),

                  // Password
                  custom_textfeild(labeltext: 'Email Adress'),
                  SizedBox(
                    height: 20,
                  ),
                  custom_textfeild(
                    labeltext: 'Password',
                    isPassword: true,
                  ),

                  // Recovery Password

                  SizedBox(height: 20),

                  // Sign In Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child:
                        Text('Sign In', style: TextStyle(color: Colors.white)),
                  ),

                  SizedBox(height: 10),

                  // Sign In with Google Button
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide.none,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    icon:
                        Image.asset('assets/images/Group 108.png', height: 24),
                    label: Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
