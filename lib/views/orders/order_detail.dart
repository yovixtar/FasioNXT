import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final String status;

  OrderDetailPage({required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pesanan #12345',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('3 item - Rp 1.125.000', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              Divider(),
              ListTile(
                leading: Icon(Icons.local_shipping),
                title: status == 'Dikemas'
                    ? Text('Status: Menunggu dikirim')
                    : Text('Status: Dikirim'),
                subtitle: status == 'Dikirim'
                    ? ElevatedButton(
                        onPressed: () {
                          // Mark as completed
                        },
                        child: Text('Selesaikan Pesanan'),
                      )
                    : null,
              ),
              Divider(),
              Text(
                'Catatan Transaksi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Informasi Kustomer:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                children: [
                  _buildTableRow('Nama:', 'John Doe'),
                  _buildTableRow('Alamat:', 'Jl. Merdeka No. 123'),
                  _buildTableRow('Tanggal:', '15 Juli 2024'),
                  _buildTableRow('Metode Pembayaran:', 'Kartu Kredit'),
                ],
              ),
              SizedBox(height: 16),
              Text('Informasi Produk:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildProductCard(
                  'Item 1', 'assets/images/product-ex.jpeg', 1, 375000),
              _buildProductCard(
                  'Item 2', 'assets/images/product-ex.jpeg', 2, 375000),
              SizedBox(height: 16),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Rp 1.125.000',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
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
      String name, String imagePath, int quantity, int price) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
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
                    '$quantity x Rp ${price.toString()}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Text(
              'Rp ${(quantity * price).toString()}',
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
