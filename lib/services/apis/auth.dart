import 'dart:convert';

import 'package:fasionxt/config.dart';
import 'package:fasionxt/services/session.dart';
import 'package:http/http.dart' as http;

class APIUserService {
  String baseUrl = Config.baseUrl;

  Future<Map<String, dynamic>> login({
    String? username,
    String? password,
  }) async {
    var response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {
        'username': username,
        'password': password,
      },
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var token = responseData['data']['token'];
      await SessionManager.saveToken(token);
      return {'success': "${responseData['message']}"};
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }

  Future<Map<String, dynamic>> register({
    String? username,
    String? password,
  }) async {
    var response = await http.post(
      Uri.parse("$baseUrl/register"),
      body: {
        'username': username,
        'password': password,
      },
    );
    var responseData = jsonDecode(response.body);
    print(responseData);
    if (responseData['code'] == 201) {
      return {'success': "${responseData['message']}"};
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }
}
