import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> getMap(String url) async {
    return (await _get(url)) as Map<String, dynamic>;
  }

  Future<List<dynamic>> getList(String url) async {
    return (await _get(url)) as List<dynamic>;
  }

  Future<dynamic> _get(String url) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      if (response.statusCode == 404) {
        throw NotFoundException();
      }

      throw Exception();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

class NotFoundException implements Exception {
  NotFoundException();
}
