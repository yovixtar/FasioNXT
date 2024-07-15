import 'package:fasionxt/views/colors.dart';
import 'package:flutter/material.dart';

class LayoutMenu extends StatefulWidget {
  final int toPage;

  const LayoutMenu({super.key, this.toPage = 0});

  @override
  State<LayoutMenu> createState() => _LayoutMenuState();
}

class _LayoutMenuState extends State<LayoutMenu> {
  int currentIndex = 0;
  List<Widget> screens = [
    Scaffold(),
    Scaffold(),
    Scaffold(),
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
      backgroundColor: bgPurple,
      bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
            ),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(Icons.home, "Home", 0),
                _buildNavItem(Icons.food_bank_outlined, "Food", 1),
                _buildNavItem(Icons.shopping_cart_outlined, "Cart", 2),
                _buildNavItem(Icons.shopping_bag_outlined, "Shop", 3),
                _buildNavItem(Icons.person, "Profile", 4),
              ],
            ),
          )),
      body: screens[currentIndex],
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
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
            (currentIndex == index)
                ? SizedBox()
                : Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
