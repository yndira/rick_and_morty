import 'package:rick_and_morty/domain/Episode.dart';
import 'package:rick_and_morty/domain/character.dart';
import 'package:rick_and_morty/domain/character_response.dart';
import 'package:rick_and_morty/domain/info_response.dart';

final infoResponsePage1 = InfoResponse(
    pages: 2,
    count: 2,
    next: "https://rickandmortyapi.com/api/character?page=2");

final characterReponsePage1 = CharacterResponse(
  info: infoResponsePage1,
  results: characters,
);

final infoResponsePage1WithName = InfoResponse(pages: 1, count: 1, next: "");

final characterReponseWithName = CharacterResponse(
  info: infoResponsePage1WithName,
  results: [character1],
);

final characterReponsePage2 = CharacterResponse(
  info: InfoResponse(
    pages: 2,
    count: 2,
  ),
  results: characters,
);

final characters = [
  character1,
  character2,
];

final character1 = Character(
  id: 1,
  name: "Rick Sanchez",
  status: Status.Alive,
  species: "Human",
  type: "",
  gender: Gender.Male,
  origin: Location(
      url: "https://rickandmortyapi.com/api/location/1", name: "Earth (C-137)"),
  location: Location(
      name: "Citadel of Ricks",
      url: "https://rickandmortyapi.com/api/location/3"),
  image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
  episodes: [
    "https://rickandmortyapi.com/api/episode/1",
    "https://rickandmortyapi.com/api/episode/2",
  ],
  url: "https://rickandmortyapi.com/api/character/1",
  created: DateTime(2017, 11, 04, 18, 48, 46),
);
final character2 = Character(
  id: 2,
  name: "Morty Smith",
  status: Status.Alive,
  species: "Human",
  type: "",
  gender: Gender.Male,
  origin: Location(
    url: "",
    name: "unknown",
  ),
  location: Location(
    name: "Citadel of Ricks",
    url: "https://rickandmortyapi.com/api/location/3",
  ),
  image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
  episodes: [
    "https://rickandmortyapi.com/api/episode/1",
    "https://rickandmortyapi.com/api/episode/2",
  ],
  url: "https://rickandmortyapi.com/api/character/2",
  created: DateTime(2017, 11, 04, 18, 50, 21),
);

final episode1 = Episode(
  name: "Episode 1",
  airDate: "",
  episode: "",
  characters: [],
  url: "",
  created: DateTime(2017, 11, 04, 18, 50, 21),
);
