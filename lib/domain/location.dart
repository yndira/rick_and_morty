import 'package:rick_and_morty/domain/character.dart';

class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<Character> residents;
  final String url;
  final DateTime created;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created
  });

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        dimension = json['dimension'],
        residents = json['residents'],
        url = json['url'],
        created = json['created'];

}
