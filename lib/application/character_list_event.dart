part of 'character_list_bloc.dart';

@freezed
class CharacterListEvent with _$CharacterListEvent {
  const factory CharacterListEvent.characterFetched() = CharacterFetched;

  const factory CharacterListEvent.nameChanged(String name) = NameChanged;

  const factory CharacterListEvent.statusChecked(Status status) = StatusChecked;

  const factory CharacterListEvent.genderChecked(Gender gender) = GenderChecked;

  const factory CharacterListEvent.favoritesShowed() = FavoritesShowed;

  const factory CharacterListEvent.favoritesHid() = FavoritesHid;

  const factory CharacterListEvent.favoriteToggled(Character character) =
      FavoriteToggled;
}
