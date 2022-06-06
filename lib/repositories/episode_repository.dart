import 'package:rick_and_morty/domain/character.dart';

import '../domain/Episode.dart';
import '../domain/episode_response.dart';
import '../services/api_service.dart';

class EpisodeRepository {
  final ApiService api;

  EpisodeRepository(this.api);

  Future<EpisodeResponse> getAll(String url) async {
    final jsonResult = await api.getMap(url);
    return EpisodeResponse.fromJson(jsonResult);
  }

  Future<Episode> get(String url) async {
    final jsonResult = await api.getMap(url);
    return Episode.fromJson(jsonResult);
  }
}
