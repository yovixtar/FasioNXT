import 'package:fasionxt/admin/views/colors.dart';
import 'package:fasionxt/admin/views/kategori/list.dart';
import 'package:fasionxt/admin/views/pesanan/list.dart';
import 'package:fasionxt/admin/views/produk/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayoutMenuAdmin extends StatefulWidget {
  final int toPage;

  const LayoutMenuAdmin({super.key, this.toPage = 0});

  @override
  State<LayoutMenuAdmin> createState() => _LayoutMenuAdminState();
}

class _LayoutMenuAdminState extends State<LayoutMenuAdmin> {
  int currentIndex = 0;
  List<Widget> screens = [
    DaftarKategori(),
    DaftarProduk(),
    OrderListPage(),
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
        color: Colors.white,
      ),
      child: ClipRRect(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.category, 0),
            _buildNavItem(Icons.shopping_basket, 1),
            _buildNavItem(Icons.receipt, 2),
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
