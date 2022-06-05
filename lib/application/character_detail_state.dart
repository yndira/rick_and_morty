part of 'character_detail_cubit.dart';

@freezed
class CharacterDetailState with _$CharacterDetailState {
  const factory CharacterDetailState({
    required Character character,
    required List<Episode> episodes,
    required BlocStatus status,
  }) = _CharacterDetailState;

  factory CharacterDetailState.initial(Character character) =>
      CharacterDetailState(
        episodes: [],
        character: character,
        status: BlocStatus.initial,
      );
}
