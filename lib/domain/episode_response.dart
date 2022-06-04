import 'package:rick_and_morty/domain/Episode.dart';

import 'info_response.dart';

class EpisodeResponse {
  final InfoResponse info;
  final List<Episode> results;

  EpisodeResponse({
    required this.info,
    required this.results,
  });

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeResponse(
        info: InfoResponse.fromJson(json["info"]),
        results:
            List<Episode>.from(json["results"].map((x) => Episode.fromJson(x))),
      );
}
