import 'package:rick_and_morty/domain/character.dart';

import '../domain/Episode.dart';
import '../domain/episode_response.dart';
import '../services/api_service.dart';

class EpisodeRepository {
  final ApiService api;

  EpisodeRepository(this.api);

  Future<EpisodeResponse> getAll(String url) async {
    try {
      final jsonResult = await api.getMap(url);
      return EpisodeResponse.fromJson(jsonResult);
    } on Exception  {
      rethrow;
    }
  }

  Future<Episode> get(String url) async {
    try {
      final jsonResult = await api.getMap(url);
      return Episode.fromJson(jsonResult);
    } on Exception {
      rethrow;
    }
  }

}
