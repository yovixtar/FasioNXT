import 'dart:convert';

import 'package:fasionxt/config.dart';
import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/services/session.dart';
import 'package:http/http.dart' as http;

class APIProdukService {
  String baseUrl = Config.baseUrl;

  Future<List<ProdukHome>> getAllProductHome() async {
    var token = await SessionManager.getToken();
    var response = await http.get(
      Uri.parse("$baseUrl/produk"),
      headers: {'Authorization': 'Bearer $token'},
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var data = responseData['data'] as List;
      List<ProdukHome> products =
          data.map((produk) => ProdukHome.fromJson(produk)).toList();
      return products;
    } else {
      return [];
    }
  }
}
