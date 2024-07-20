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

  Future<List<ProdukHome>> getFavoritProduct() async {
    var token = await SessionManager.getToken();
    var response = await http.get(
      Uri.parse("$baseUrl/produk/favorit"),
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

  Future<Map<String, dynamic>> favoritProduct({
    String? produk_id,
  }) async {
    var token = await SessionManager.getToken();
    var response = await http.post(
      Uri.parse("$baseUrl/produk/favorit"),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'produk_id': produk_id,
      },
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      return {'success': "${responseData['message']}"};
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }
}
