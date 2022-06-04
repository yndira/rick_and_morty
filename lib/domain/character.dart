import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final Status status;
  final String species;
  final String type;
  final Gender gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episodes;
  final String url;
  final DateTime created;
  bool favorite;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodes,
    required this.url,
    required this.created,
    this.favorite = false,
  });

  @override
  String toString() {
    return "$id - $name";
  }

  static const favorites = [1, 2, 5, 20, 30];

  static List<Character> listFromJsonMap(Map<String, dynamic> json) {
    final map = json["results"];
    return map
        .map((s) => Character.fromJson(s as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  static List<Character> listFromJsonList(List<dynamic> json) {
    return json
        .map((s) => Character.fromJson(s as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: statusByNameOrDefault(json['status']),
      species: json['species'],
      type: json['type'],
      gender: Gender.values.byName(json['gender']),
      origin: Location.fromJson(json['origin'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'],
      episodes: List<String>.from(json["episode"].map((x) => x)),
      url: json['url'],
      created: DateTime.parse(json["created"]),
      favorite: favorites.contains(json['id']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status.name,
        "species": species,
        "type": type,
        "gender": gender.name,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episodes.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episodes,
        url,
        created,
        favorite
      ];
}

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Status { Alive, Dead, unknown }

enum Gender { Female, Male, Genderless, unknown }

Status statusByNameOrDefault(String name) {
  for (var value in Status.values) {
    if (value.toString() == name) {
      return value;
    }
  }

  return Status.unknown;
}

Gender genderByNameOrDefault(String name) {
  for (var value in Gender.values) {
    if (value.toString() == name) {
      return value;
    }
  }

  return Gender.unknown;
}
