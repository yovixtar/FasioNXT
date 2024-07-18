import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pusat Bantuan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHelpItem(
                context, 'Cara Membuat Akun', 'Instruksi untuk membuat akun.'),
            _buildHelpItem(context, 'Cara Mengubah Profil',
                'Instruksi untuk mengubah profil pengguna.'),
            _buildHelpItem(context, 'Cara Melakukan Transaksi',
                'Instruksi untuk melakukan transaksi di aplikasi.'),
            _buildHelpItem(context, 'Cara Menghubungi Dukungan',
                'Informasi kontak dukungan.'),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(
      BuildContext context, String title, String description) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HelpDetailPage(title: title, description: description)),
          );
        },
      ),
    );
  }
}

class HelpDetailPage extends StatelessWidget {
  final String title;
  final String description;

  HelpDetailPage({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
