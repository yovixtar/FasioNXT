import 'package:fasionxt/views/notif/notif_detail.dart';
import 'package:flutter/material.dart';

class NotificationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: 10, // Jumlah notifikasi, ganti sesuai kebutuhan
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.blue),
              title: Text('Notifikasi #$index',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text('Deskripsi notifikasi #$index',
                  style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationDetailPage(
                            notificationDate: "2024-07-17",
                            notificationDescription: "ini deskripsi notifikasi",
                            notificationTitle: "Judul Notifikasi",
                          )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
