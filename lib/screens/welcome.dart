import 'package:lac/screens/control.dart';
import 'package:lac/screens/data.dart';
import 'package:lac/screens/map.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final pageViewController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageViewController,
        children: [
          DataScreen(),
          ControlScreen(),
          MapScreen(),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        pageViewController: pageViewController,
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({this.pageViewController});

  final PageController pageViewController;

  @override
  Widget build(BuildContext context) {
    double iconSize = 35;
    return AnimatedBuilder(
      animation: pageViewController,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          unselectedItemColor: Colors.grey[600],
          selectedItemColor: Colors.blue,
          unselectedFontSize: 15,
          selectedFontSize: 17,
          currentIndex: pageViewController?.page?.round() ?? 0,
          onTap: (index) {
            pageViewController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.article,
                size: iconSize,
              ),
              label: "Data",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.keyboard_rounded,
                size: iconSize,
              ),
              label: "Controls",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
                size: iconSize,
              ),
              label: "UAV Info",
            ),
          ],
        );
      },
    );
  }
}
