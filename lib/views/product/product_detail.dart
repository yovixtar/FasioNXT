import 'dart:convert';

import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/services/apis/produk.dart';
import 'package:fasionxt/services/cart_manager.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/layout_menu.dart';
import 'package:fasionxt/views/orders/order_confirm.dart';
import 'package:fasionxt/views/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail(
      {super.key, required this.product, required this.isFavorite});

  final Produk product;
  final bool isFavorite;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isLoading = false;
  bool isFavorite = false;
  int cartCount = 0;

  late List<String> availableSizes;
  late String selectedSize;

  handleFavorite() async {
    final result =
        await APIProdukService().favoritProduct(produk_id: widget.product.id);
    if (result.containsKey('success')) {
      SnackbarUtils.showSuccessSnackbar(context, result['success']);
    } else {
      SnackbarUtils.showErrorSnackbar(context, result['error']);
    }
  }

  @override
  void initState() {
    super.initState();
    availableSizes = _convertStringToList(widget.product.ukuran);
    selectedSize = availableSizes.first;
    isFavorite = widget.isFavorite;
  }

  List<String> _convertStringToList(String sizeString) {
    List<dynamic> sizeList = json.decode(sizeString);
    return sizeList.map((size) => size.toString()).toList();
  }

  void handleCart() {
    showOrderDialog(context, "Tambahkan Keranjang", handleAddToCart);
  }

  void handleBeliSekarang() {
    showOrderDialog(context, "Beli Sekarang", handleBuyNow);
  }

  void handleAddToCart(int quantity, String size) {
    setState(() {
      cartCount += quantity;
    });
    Navigator.of(context).pop();
    CartManager.addToCart(widget.product, quantity, size);
    SnackbarUtils.showSuccessSnackbar(
        context, "Berhasil menambahkan produk ke Keranjang.");
  }

  void handleBuyNow(int quantity, String size) {
    Navigator.of(context).pop();
    Map<String, dynamic> directItem = {
      'product': widget.product.toJson(),
      'quantity': quantity,
      'size': size,
    };
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OrderConfirmationPage(
          cartItems: [],
          directItem: directItem,
          total: (int.parse(widget.product.harga) * quantity).toString(),
        ),
      ),
    );
  }

  void showOrderDialog(
      BuildContext context, String actionText, Function(int, String) onSubmit) {
    int quantity = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Order Now!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Pilih Jumlah Produk"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: quantity > 0
                            ? () => setState(() => quantity--)
                            : null,
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: quantity < int.parse(widget.product.stok)
                            ? () {
                                setState(() => quantity++);
                              }
                            : null,
                      ),
                    ],
                  ),
                  Text("Pilih Ukuran Produk"),
                  DropdownButton<String>(
                    value: selectedSize,
                    items: availableSizes.map((String size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (String? newSize) {
                      setState(() {
                        selectedSize = newSize!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: quantity > 0
                        ? () => onSubmit(quantity, selectedSize)
                        : null,
                    child: Text(
                      actionText,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purplePrimary,
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<int> _getQuantityAllProduct() async {
    return await CartManager.getQuantityAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlue,
      appBar: AppBar(
        backgroundColor: bgBlue,
        title: Text(
          "Kembali",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          Stack(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LayoutMenu(
                        toPage: 2,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.shopping_cart_outlined),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  backgroundColor: Colors.white,
                  foregroundColor: bluePrimary,
                ),
              ),
              FutureBuilder<int>(
                  future: _getQuantityAllProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      int totalQuantity = snapshot.data ?? 0;
                      return Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            totalQuantity.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Image.network(
                                  widget.product.gambar,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.nama,
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    Text(
                                      'Rp ' +
                                          widget.product.harga.replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => '${m[1]}.') +
                                          ',-',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: purplePrimary,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                    handleFavorite();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 7,
                                            spreadRadius: 2)
                                      ],
                                    ),
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: heartRed,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.product.deskripsi,
                              style:
                                  TextStyle(color: greyPrimary, fontSize: 14),
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: handleCart,
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 25,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: purplePrimary,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: handleBeliSekarang,
                    child: Text(
                      "Pesan Sekarang",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: purplePrimary,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  ),
                  SizedBox(
                    width: 10,
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
