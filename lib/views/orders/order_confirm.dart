import 'package:fasionxt/views/layout_menu.dart';
import 'package:flutter/material.dart';
import 'package:fasionxt/models/produk.dart';

class OrderConfirmationPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const OrderConfirmationPage({super.key, required this.cartItems});

  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    num total = 0;
    for (var item in widget.cartItems) {
      int quantity = int.parse(item['quantity'].toString());
      double harga = double.parse(item['product']['harga'].toString());
      total += quantity * harga;
    }
    setState(() {
      totalPrice = total.toInt();
    });
  }

  void _completeProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LayoutMenu(
          toPage: 3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pesanan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  var item = widget.cartItems[index];
                  var product = Produk.fromJson(item['product']);
                  return ListTile(
                    leading: Image.network(product.gambar),
                    title: Text(product.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rp ${product.harga}'),
                        Text('Jumlah: ${item['quantity']}'),
                        Text('Ukuran: ${item['size']}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _completeProfile,
                child: Text('Lengkapi Profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
