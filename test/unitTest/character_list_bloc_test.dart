import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:rick_and_morty/domain/info_response.dart';

import '../fixtures/fixtures.dart';
import '../fixtures/mocks.dart';

void main() {
  late MockCharacterRepository mockCharcaterRepo;
  late MockEpisodeRepository mockEpisodeRepo;

  final stateInitial = CharacterListState(
    hasReachedMax: false,
    blocStatus: BlocStatus.initial,
    characters: [],
    charactersFavorites: [],
    info: InfoResponse(
      pages: 0,
      count: 0,
      next: "https://rickandmortyapi.com/api/character?page=1",
    ),
    showFavorites: true,
  );

  setUp(() async {
    mockCharcaterRepo = MockCharacterRepository();
    mockEpisodeRepo = MockEpisodeRepository();
  });

  test('state inicial es Initial', () {
    var bloc = CharacterListBloc(mockCharcaterRepo, mockEpisodeRepo);
    final stateExpected = stateInitial;

    expect(bloc.state, stateExpected);
  });

  blocTest<CharacterListBloc, CharacterListState>(
      'debería buscar la siguiente pagina si evento CharacterFetched ',
      build: () => CharacterListBloc(mockCharcaterRepo, mockEpisodeRepo),
      setUp: () {
        final response = characterReponsePage1;
        final episodes = [episode1, episode1];

        when(() => mockCharcaterRepo.getAllWithInfo(any()))
            .thenAnswer((_) async => response);
        when(() => mockEpisodeRepo.get(any())).thenAnswer((_) async {
          final epi = episodes.first;
          episodes.removeAt(0);
          return Future.value(epi);
        });
      },
      act: (bloc) {
        bloc.add(CharacterListEvent.characterFetched());
      },
      wait: const Duration(milliseconds: 200),
      expect: () {
        final infoExpected = infoResponsePage1;
        final charactersExpected = characters;

        return [
          isA<CharacterListState>()
              .having((s) => s.blocStatus, "blocStatus", BlocStatus.loading),
          isA<CharacterListState>()
              .having((s) => s.blocStatus, "blocStatus", BlocStatus.success)
              .having((s) => s.info, "info", infoExpected)
              .having((s) => s.characters, "characters", charactersExpected),
        ];
      },
      verify: (_) {
        verify(() => mockCharcaterRepo.getAllWithInfo(
            "https://rickandmortyapi.com/api/character?page=1"));
      });

  blocTest<CharacterListBloc, CharacterListState>(
      'debería buscar charcaters por nombre si evento es NameChanged',
      build: () => CharacterListBloc(mockCharcaterRepo, mockEpisodeRepo),
      setUp: () {
        final response = characterReponseWithName;
        when(() => mockCharcaterRepo.getAllWithInfo(any()))
            .thenAnswer((_) async => response);
        when(() => mockEpisodeRepo.get(any()))
            .thenAnswer((_) async => Future.value(episode1));
      },
      act: (bloc) {
        bloc.add(const CharacterListEvent.nameChanged("rick"));
      },
      wait: const Duration(milliseconds: 200),
      expect: () {
        final infoExpected = infoResponsePage1WithName;
        final charactersExpected = [character1];

        return [
          isA<CharacterListState>()
              .having((s) => s.blocStatus, "blocStatus", BlocStatus.initial),
          isA<CharacterListState>()
              .having((s) => s.blocStatus, "blocStatus", BlocStatus.loading),
          isA<CharacterListState>()
              .having((s) => s.blocStatus, "blocStatus", BlocStatus.success)
              .having((s) => s.info, "info", infoExpected)
              .having((s) => s.characters, "characters", charactersExpected),
        ];
      },
      verify: (_) {
        verify(() => mockCharcaterRepo.getAllWithInfo(
            "https://rickandmortyapi.com/api/character?page=1&name=rick"));
      });
}
