import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/colors.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  XFile? image;
  final TextEditingController _nameController =
      TextEditingController(text: "Irshad");
  final TextEditingController _emailController =
      TextEditingController(text: "irshadvp800@gmail.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "9072130225");

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(35.0),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Profile Photo",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Airbnb",
                              fontSize: 20)),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[200],
                                title: Text("Remove Profile Photo"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        image = null;
                                      });
                                    },
                                    child: Text("Remove",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 65,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColors,
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    final pickedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (pickedImage != null) {
                                      setState(() {
                                        image = pickedImage;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColors,
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    final pickedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (pickedImage != null) {
                                      setState(() {
                                        image = pickedImage;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.photo,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColors)),
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColors,
        child: Stack(
          children: [
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
              left: 120,
              child: Text(
                "Edit Profile",
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: image != null
                                      ? FileImage(File(image!.path))
                                      : AssetImage('assets/images/img_8.png')
                                          as ImageProvider,
                                )),
                            Positioned(
                              right: 20,
                              bottom: 10,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColors,
                                ),
                                child: IconButton(
                                  onPressed: () => _showBottomSheet(context),
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
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
                          ),
                        ),
                        SizedBox(height: 20),
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
                              // Handle the save or done action here
                              // For example, saving the profile data locally
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Done",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
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
