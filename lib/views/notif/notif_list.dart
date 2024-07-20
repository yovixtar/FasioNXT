import 'package:fasionxt/models/notifikasi.dart';
import 'package:fasionxt/services/apis/notifikasi.dart';
import 'package:fasionxt/views/notif/notif_detail.dart';
import 'package:flutter/material.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({Key? key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  late Future<List<Notifikasi>> _dataNotif;

  @override
  void initState() {
    super.initState();
    _dataNotif = fetchNotif();
  }

  Future<List<Notifikasi>> fetchNotif() async {
    List<Notifikasi> dataNotif =
        await APINotifikasiService().getAllUserNotifikasi();
    return dataNotif;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: FutureBuilder<List<Notifikasi>>(
        future: _dataNotif,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Notifikasi> dataNotif = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: dataNotif.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(Icons.notifications, color: Colors.blue),
                    title: Text(dataNotif[index].judul,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(dataNotif[index].deskripsi,
                        style: TextStyle(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationDetailPage(
                                  notification: dataNotif[index],
                                )),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error fetching products ${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
