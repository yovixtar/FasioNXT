import 'dart:convert';

import 'package:fasionxt/config.dart';
import 'package:fasionxt/models/notifikasi.dart';
import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/services/session.dart';
import 'package:http/http.dart' as http;

class APINotifikasiService {
  String baseUrl = Config.baseUrl;

  Future<List<Notifikasi>> getAllUserNotifikasi() async {
    var token = await SessionManager.getToken();
    var response = await http.get(
      Uri.parse("$baseUrl/notifikasi"),
      headers: {'Authorization': 'Bearer $token'},
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var data = responseData['data'] as List;
      List<Notifikasi> notifs =
          data.map((notif) => Notifikasi.fromJson(notif)).toList();
      return notifs;
    } else {
      return [];
    }
  }
}
