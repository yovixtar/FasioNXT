import 'dart:convert';

import 'package:fasionxt/config.dart';
import 'package:fasionxt/models/pesanan.dart';
import 'package:fasionxt/services/notification.dart';
import 'package:fasionxt/services/session.dart';
import 'package:http/http.dart' as http;

class APIPesananService {
  String baseUrl = Config.baseUrl;

  Future<List<DaftarPesanan>> getAllPesanan() async {
    var token = await SessionManager.getToken();
    var response = await http.get(
      Uri.parse("$baseUrl/pesanan"),
      headers: {'Authorization': 'Bearer $token'},
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var data = responseData['data'] as List;
      List<DaftarPesanan> pesanans =
          data.map((pesanan) => DaftarPesanan.fromJson(pesanan)).toList();
      return pesanans;
    } else {
      return [];
    }
  }

  Future checkout({items, catatan, total}) async {
    var token = await SessionManager.getToken();
    var response = await http.post(
      Uri.parse("$baseUrl/checkout"),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'items': "${jsonEncode(items)}",
        'catatan': catatan,
        'total': total,
      },
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      if (responseData['data']['notif'] != null) {
        LocalNotificationService.display(
          responseData['data']['notif']['judul'],
          responseData['data']['notif']['deskripsi'],
        );
      }
      return Pesanan.fromJson(responseData['data']);
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }

  Future<Map<String, dynamic>> selesaiPesanan({
    required String id_pesanan,
  }) async {
    try {
      var token = await SessionManager.getToken();

      var response = await http.post(
        Uri.parse("$baseUrl/pesanan/selesai"),
        headers: {'Authorization': 'Bearer $token'},
        body: {'id_pesanan': id_pesanan},
      );

      var responseData = jsonDecode(response.body);
      print(responseData);
      if (responseData['code'] == 200) {
        if (responseData['data']['notif'] != null) {
          LocalNotificationService.display(
            responseData['data']['notif']['judul'],
            responseData['data']['notif']['deskripsi'],
          );
        }
        return {'success': "${responseData['message']}"};
      } else {
        return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
      }
    } catch (e) {
      return {'error': "Terjadi kesalahan: $e"};
    }
  }
}
