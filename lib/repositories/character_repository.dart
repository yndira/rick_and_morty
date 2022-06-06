import 'package:rick_and_morty/domain/character_response.dart';
import 'package:rick_and_morty/services/api_service.dart';

import '../domain/character.dart';

class CharacterRepository {
  final ApiService api;

  CharacterRepository(this.api);

  Future<CharacterResponse> getAllWithInfo(String url) async {
    final jsonResult = await api.getMap(url);
    return CharacterResponse.fromJson(jsonResult);
  }

  Future<List<Character>> getAll(String url) async {
    final jsonResult = await api.getList(url);
    return Character.listFromJsonList(jsonResult);
  }
}
