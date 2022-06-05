part of 'character_list_bloc.dart';

enum BlocStatus { initial, loading, success, failure }

@freezed
class CharacterListState with _$CharacterListState {
  const factory CharacterListState({
    required InfoResponse info,
    required List<Character> characters,
    required List<Character> charactersFavorites,
    required bool hasReachedMax,
    required BlocStatus blocStatus,
    required bool showFavorites,
    String? name,
    Status? status,
    Gender? gender,
    String? error,
  }) = _CharacterState;

  factory CharacterListState.initial() => CharacterListState(
        hasReachedMax: false,
        blocStatus: BlocStatus.initial,
        characters: [],
        charactersFavorites: [],
        info: InfoResponse(
          pages: 0,
          count: 0,
          next: "${Endpoint.getAllCharacter}?page=1",
        ),
        showFavorites: true,
      );

  factory CharacterListState.filter({
    String? name,
    Status? status,
    Gender? gender,
  }) =>
      CharacterListState(
        hasReachedMax: false,
        blocStatus: BlocStatus.initial,
        name: name,
        status: status,
        gender: gender,
        characters: [],
        charactersFavorites: [],
        info: InfoResponse(
          pages: 0,
          count: 0,
          next: "${Endpoint.getAllCharacter}?page=1"
              "${name != null ? '&name=$name' : ''}"
              "${status != null ? '&status=${status.name}' : ''}"
              "${gender != null ? '&gender=${gender.name}' : ''}",
        ),
        showFavorites: true,
      );
}
