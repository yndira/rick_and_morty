import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../domain/character.dart';

class ApiService {
  Future<void> getCharacters() async {
    print("estoy en getCharacters");

    final request = http.Request(
        "GET", Uri.parse("https://rickandmortyapi.com/api/character"));
    final response = await request.send();

    if (response.statusCode == 200) {
      print('status 200');
      final jsonString = await response.stream.bytesToString();
      final xlsResponse = Character.listFromJsonMap(json.decode(jsonString));
      xlsResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

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

      throw Exception();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
