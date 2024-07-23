import 'package:flutter/material.dart';
import 'package:shoes/Screens/auth/login_page.dart';
import 'package:shoes/Screens/splash_screens/splash3.dart';

class splash2 extends StatefulWidget {
  splash2({Key? key}) : super(key: key);

  @override
  State<splash2> createState() => _splash2State();
}

class _splash2State extends State<splash2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<String> butonname = ['Next', 'Next', 'Get Started'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    // Replace with your actual pages
                    splash1_3(
                      image: 'assets/images/Digital Sketches_prev_ui.png',
                    ),
                    splash1_3(
                      image:
                          'assets/images/81a48fdfedf49d08648513dc1826f8f2_prev_ui 1.png',
                      roundimage: Image.asset('assets/images/Ellipse 907.png'),
                    ),
                    splash1_3(
                      image: 'assets/images/Spring_prev_ui 1.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      width: _currentPage == index ? 40.0 : 10.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    );
                  }),
                ),
                Positioned(
                  bottom: 10,
                  right: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == 2) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }
                    },
                    child: Text(
                      butonname[_currentPage],
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
