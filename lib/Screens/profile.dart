import 'package:flutter/material.dart';
import 'package:shoes/Screens/home_screen.dart';

import '../utils/colors.dart';
import 'EditProfile.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  final TextEditingController _nameController =
      TextEditingController(text: "Irshad");
  final TextEditingController _emailController =
      TextEditingController(text: "irshadvp800@gmail.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "9072130225");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColors,
        child: Stack(
          children: [
            Positioned(
              top: 40,
              right: 5, // Adjusted right position
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("LogOut", style: TextStyle(color: Colors.white70)),
                        const SizedBox(width: 5), // Adjusted spacing
                        const Icon(
                          Icons.logout,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 15,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
              top: 45,
              left: 130,
              child: Text(
                "Profile",
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
              top: 90,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Irshad',
                            labelStyle: TextStyle(color: primaryColors),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(39),
                              borderSide: BorderSide(color: primaryColors),
                            ),
                          ),
                          controller: _nameController,
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'irshadvp800@gmail.com',
                            labelStyle: TextStyle(color: primaryColors),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(39),
                              borderSide: BorderSide(color: primaryColors),
                            ),
                          ),
                          controller: _emailController,
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            hintText: '9072130225',
                            labelStyle: TextStyle(color: primaryColors),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(39),
                              borderSide: BorderSide(color: primaryColors),
                            ),
                          ),
                          controller: _phoneController,
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColors,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
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
