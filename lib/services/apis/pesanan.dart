import 'dart:convert';

import 'package:fasionxt/config.dart';
import 'package:fasionxt/models/pesanan.dart';
import 'package:fasionxt/services/session.dart';
import 'package:http/http.dart' as http;

class APIPesananService {
  String baseUrl = Config.baseUrl;

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
      return Pesanan.fromJson(responseData['data']);
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }

  Future<Map<String, dynamic>> pengaturanAkun({
    String? username,
    String? nama,
    String? passwordLama,
    String? passwordBaru,
    String? alamat,
  }) async {
    var token = await SessionManager.getToken();
    Map<String, String> body = {};

    if (username != null) body['username'] = username;
    if (nama != null) body['nama'] = nama;
    if (passwordLama != null && passwordBaru != null) {
      body['password_lama'] = passwordLama;
      body['password_baru'] = passwordBaru;
    }
    if (alamat != null) body['alamat'] = alamat;

    var response = await http.post(
      Uri.parse("$baseUrl/profile/setting"),
      headers: {'Authorization': 'Bearer $token'},
      body: body,
    );

    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      return {'success': "${responseData['message']}"};
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }
}
