import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/services/cart_manager.dart';
import 'package:fasionxt/views/cart/cart_item.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/orders/order_confirm.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  List<Map<String, dynamic>> cartItems = [];
  int shipping = 0;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() async {
    setState(() {
      isLoading = true;
    });
    cartItems = await CartManager.getCart();
    setState(() {
      isLoading = false;
    });
  }

  void _increaseQuantity(int index) async {
    await CartManager.increaseQuantity(index);
    _loadCart();
  }

  void _decreaseQuantity(int index) async {
    await CartManager.decreaseQuantity(index);
    _loadCart();
  }

  void _removeFromCart(int index) async {
    await CartManager.removeFromCart(index);
    _loadCart();
  }

  Future<int> _getTotalPrice() async {
    return await CartManager.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightRed,
      appBar: AppBar(
        backgroundColor: bgLightRed,
        title: Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            "Keranjang Saya",
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                ),
          ),
        ),
        automaticallyImplyLeading: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: ClipOval(
              child: Image.asset(
                'assets/images/icon-profile.jpeg',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              (cartItems.length == 0)
                                  ? Center(
                                      child:
                                          Text("Yah Kosong, Mari Berbelanja !"),
                                    )
                                  : SizedBox(),
                              ...List.generate(
                                cartItems.length,
                                (index) {
                                  return ItemCart(
                                    product: Produk.fromJson(
                                        cartItems[index]['product']),
                                    jumlah:
                                        cartItems[index]['quantity'].toString(),
                                    ukuran: cartItems[index]['size'],
                                    onDelete: () {
                                      _removeFromCart(index);
                                    },
                                    onUpdate: (size) {
                                      setState(() {
                                        CartManager.updateSizeCart(index, size);
                                        _loadCart();
                                      });
                                    },
                                    onIncrease: () {
                                      _increaseQuantity(index);
                                    },
                                    onDecrease: () {
                                      _decreaseQuantity(index);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FutureBuilder<int>(
                            future: _getTotalPrice(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                int totalPrice = snapshot.data ?? 0;
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Total :",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Rp. ' +
                                              totalPrice
                                                  .toString()
                                                  .replaceAllMapped(
                                                      RegExp(
                                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                      (Match m) => '${m[1]}.'),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Shipping :",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Rp. ' +
                                              shipping.toString().replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]}.'),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Grand Total :",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Rp ' +
                                              (totalPrice + shipping)
                                                  .toString()
                                                  .replaceAllMapped(
                                                      RegExp(
                                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                      (Match m) => '${m[1]}.'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderConfirmationPage(
                              cartItems: cartItems,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: purplePrimary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
