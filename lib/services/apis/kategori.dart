import 'dart:convert';

import 'package:fasionxt/config.dart';
import 'package:fasionxt/models/kategori.dart';
import 'package:http/http.dart' as http;

class APIKategoriService {
  String baseUrl = Config.baseUrl;

  Future<List<Kategori>> getAllCategory() async {
    var response = await http.get(
      Uri.parse("$baseUrl/kategori"),
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var data = responseData['data'] as List;
      List<Kategori> kategories =
          data.map((kategori) => Kategori.fromJson(kategori)).toList();
      return kategories;
    } else {
      return [];
    }
  }
}
