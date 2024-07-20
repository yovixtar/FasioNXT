import 'package:fasionxt/models/pengguna.dart';
import 'package:fasionxt/services/apis/pesanan.dart';
import 'package:fasionxt/services/apis/profile.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/layout_menu.dart';
import 'package:fasionxt/views/payment/payment_view.dart';
import 'package:fasionxt/views/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String total;

  const OrderConfirmationPage(
      {super.key, required this.cartItems, required this.total});

  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final _catatanController = TextEditingController(text: "");
  bool isCompleate = false;
  bool isLoading = false;
  late Future<Pengguna> _dataPengguna;

  Future<Pengguna> fetchPengguna() async {
    Pengguna dataPengguna = await APIProfileService().getCurrentUser();
    return dataPengguna;
  }

  @override
  void initState() {
    super.initState();
    _dataPengguna = fetchPengguna();
  }

  handleCheckout() async {
    setState(() {
      isLoading = true;
    });
    final result = await APIPesananService().checkout(
      catatan: _catatanController.text,
      total: widget.total,
      items: widget.cartItems,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentViewPage(
          pesanan: result,
          pesananItems: widget.cartItems,
        ),
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightRed,
      appBar: AppBar(
        title: Text('Konfirmasi Pesanan'),
        backgroundColor: bgLightRed,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Catatan Tambahan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _catatanController,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.note_add, color: purplePrimary),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true),
              ),
              SizedBox(height: 8),
              Text('Informasi Kustomer:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              FutureBuilder<Pengguna>(
                future: _dataPengguna,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.nama.isNotEmpty ||
                        snapshot.data!.alamat.isNotEmpty) {
                      isCompleate = true;
                    }
                    return Table(
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        _buildTableRow('Nama:', snapshot.data!.nama),
                        _buildTableRow('Alamat:', snapshot.data!.alamat),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error fetching profile ${snapshot.error}');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LayoutMenu(
                          toPage: 3,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluePrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Lengkapi Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Informasi Produk:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ...widget.cartItems.map((item) {
                return _buildProductCard(
                    item['product']['nama'],
                    item['product']['gambar'],
                    item['quantity'],
                    item['product']['harga']);
              }),
              SizedBox(height: 16),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                      'Rp' +
                          widget.total.replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]}.'),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    isCompleate ? handleCheckout() : null;
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => Scaffold(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluePrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Bayar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
      String name, String imagePath, int quantity, String price) {
    return Card(
      color: bgGrey,
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              imagePath,
              height: 50,
              width: 50,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$quantity x Rp ${price.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Text(
              'Rp ' +
                  (quantity * int.parse(price)).toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]}.'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
