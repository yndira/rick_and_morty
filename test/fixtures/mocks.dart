import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/repositories/episode_repository.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

class MockEpisodeRepository extends Mock implements EpisodeRepository {}
