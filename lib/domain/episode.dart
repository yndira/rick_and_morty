class Episode {
  int? id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime created;

  Episode(
      {this.id,
      required this.name,
      required this.airDate,
      required this.episode,
      required this.characters,
      required this.url,
      required this.created});

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        airDate = json['air_date'],
        episode = json['episode'],
        characters = List<String>.from(json["characters"].map((x) => x)),
        url = json['url'],
        created = DateTime.parse(json['created']);
}
