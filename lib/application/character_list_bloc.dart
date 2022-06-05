import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/domain/info_response.dart';
import 'package:rick_and_morty/services/endpoint.dart';
import 'package:rxdart/rxdart.dart';

import '../domain/character.dart';
import '../repositories/character_repository.dart';

part 'character_list_bloc.freezed.dart';

part 'character_list_event.dart';

part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final CharacterRepository repo;

  CharacterListBloc(this.repo) : super(CharacterListState.initial()) {
    on<CharacterFetched>(
      _onCharacterFetched,
      transformer: debounceTransformer(const Duration(milliseconds: 200)),
    );
    on<NameChanged>(
      _onNameChanged,
      transformer: debounceTransformer(const Duration(milliseconds: 500)),
    );
    on<StatusChecked>(_onStatusChanged);
    on<GenderChecked>(_onGenderChanged);
    on<FavoritesShowed>(_onFavoritesShowed);
    on<FavoritesHid>(_onFavoritesHid);
    on<FavoriteToggled>(_onFavoriteToggled);
  }

  Future<void> _onCharacterFetched(CharacterFetched event, Emitter emit) async {
    await _onFetchCharacters(emit);
  }

  Future<void> _onNameChanged(NameChanged event, Emitter emit) async {
    emit(CharacterListState.filter(
        name: event.name, status: state.status, gender: state.gender));
    await _onFetchCharacters(emit);
  }

  Future<void> _onStatusChanged(StatusChecked event, Emitter emit) async {
    emit(CharacterListState.filter(
        name: state.name, status: event.status, gender: state.gender));

    await _onFetchCharacters(emit);
  }

  Future<void> _onGenderChanged(GenderChecked event, Emitter emit) async {
    emit(CharacterListState.filter(
        name: state.name, status: state.status, gender: event.gender));
    await _onFetchCharacters(emit);
  }

  Future<void> _onFavoritesShowed(FavoritesShowed event, Emitter emit) async {
    final favorites = state.characters.where((c) => c.favorite).toList();
    emit(state.copyWith(
      showFavorites: false,
      charactersFavorites: favorites,
    ));
  }

  Future<void> _onFavoritesHid(FavoritesHid event, Emitter emit) async {
    emit(state.copyWith(
      showFavorites: true,
      charactersFavorites: [],
    ));
  }

  Future<void> _onFetchCharacters(Emitter emit) async {
    try {
      emit(state.copyWith(blocStatus: BlocStatus.loading));

      var nextUrl = state.info.next;

      if (nextUrl != null) {
        final response = await repo.getAllWithInfo(nextUrl);
        emit(state.copyWith(
          info: response.info,
          characters: List.of(state.characters)..addAll(response.results),
          hasReachedMax: response.info.next == null,
          blocStatus: BlocStatus.success,
        ));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
          blocStatus: BlocStatus.success,
        ));
      }
    } on Exception {
      emit(state.copyWith(
        blocStatus: BlocStatus.failure,
      ));
    }
  }

  Future<void> _onFavoriteToggled(FavoriteToggled event, Emitter emit) async {
    final charactersCopy =
        state.characters.map((e) => Character.copy(e)).toList();
    final character =
        charactersCopy.firstWhereOrNull((c) => c.id == event.character.id);

    if (character != null) {
      character.favorite = !character.favorite;

      emit(state.copyWith(
        characters: charactersCopy,
      ));
    }
  }
}

EventTransformer<E> debounceTransformer<E>(Duration duration) {
  return (events, mapper) {
    return events.debounceTime(duration).switchMap(mapper);
  };
}
