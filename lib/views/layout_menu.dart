import 'package:fasionxt/views/cart/cart_page.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayoutMenu extends StatefulWidget {
  final int toPage;

  const LayoutMenu({super.key, this.toPage = 0});

  @override
  State<LayoutMenu> createState() => _LayoutMenuState();
}

class _LayoutMenuState extends State<LayoutMenu> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomePage(),
    Scaffold(),
    CartPage(),
    Scaffold(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.toPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildNavBar(),
      body: screens[currentIndex],
    );
  }

  Widget _buildNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.circular(35),
        //   topLeft: Radius.circular(35),
        // ),
        color: Colors.white,
      ),
      child: ClipRRect(
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(30.0),
        //   topRight: Radius.circular(30.0),
        // ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.notifications, 1),
            _buildNavItem(Icons.shopping_cart, 2),
            _buildNavItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: (currentIndex == index)
                  ? EdgeInsets.all(8)
                  : EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.white
                      : const Color.fromARGB(0, 0, 0, 0),
                  shape: BoxShape.circle),
              child: Icon(
                icon,
                size: (currentIndex == index) ? 35 : 30,
                color: currentIndex == index ? ancientRed : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
