import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/application/character_detail_cubit.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import '../fixtures/fixtures.dart';
import '../fixtures/mocks.dart';

void main() {
  late MockCharacterRepository mockCharcaterRepo;
  late MockEpisodeRepository mockEpisodeRepo;

  final stateInitial = CharacterDetailState(
    episodes: [],
    character: character1,
    status: BlocStatus.initial,
    interestingCharacters: [],
  );

  setUp(() async {
    mockCharcaterRepo = MockCharacterRepository();
    mockEpisodeRepo = MockEpisodeRepository();
  });

  test('state inicial es Initial', () {
    var bloc =
        CharacterDetailCubit(character1, mockEpisodeRepo, mockCharcaterRepo);
    final stateExpected = stateInitial;

    expect(bloc.state, stateExpected);
  });

  blocTest<CharacterDetailCubit, CharacterDetailState>(
    'debería cargar episodios y los tres primeros characters interesantes',
    build: () =>
        CharacterDetailCubit(character1, mockEpisodeRepo, mockCharcaterRepo),
    setUp: () async {
      final characters = [character1, character2, character3];
      final episodes = [episode1, episode2, episode1, episode1, episode1];

      when(() => mockEpisodeRepo.get(any())).thenAnswer((_) async {
        final epi = episodes.first;
        episodes.removeAt(0);
        return Future.value(epi);
      });

      when(() => mockCharcaterRepo.getAll(any()))
          .thenAnswer((_) async => characters);
    },
    act: (cubit) {
      cubit.load();
    },
    expect: () {
      final charactersExpected = [character1, character2, character3];
      final episodesExpected = [episode1, episode2];

      return [
        isA<CharacterDetailState>()
            .having((s) => s.status, "status", BlocStatus.loading),
        isA<CharacterDetailState>()
            .having((s) => s.status, "status", BlocStatus.success)
            .having((s) => s.episodes, "episodes", episodesExpected)
            .having((s) => s.interestingCharacters, "characters",
                charactersExpected)
            .having((s) => s.interestingCharacters.length,
                "cantidad characters interesantes", 3),
      ];
    },
    verify: (cubit) {
      verify(() => mockCharcaterRepo
          .getAll("https://rickandmortyapi.com/api/character/1,2,5"));
    },
  );
}
