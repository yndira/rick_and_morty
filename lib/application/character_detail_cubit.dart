import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';
import 'package:rick_and_morty/domain/Episode.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';

import '../domain/character.dart';
import '../repositories/episode_repository.dart';
import '../services/endpoint.dart';

part 'character_detail_state.dart';

part 'character_detail_cubit.freezed.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  static const favorites = [1, 2, 5, 20, 30];

  final EpisodeRepository episodeRepo;
  final CharacterRepository characterRepo;

  CharacterDetailCubit(
      Character character, this.episodeRepo, this.characterRepo)
      : super(CharacterDetailState.initial(character));

  Future<void> load() async {
    emit(state.copyWith(status: BlocStatus.loading));
    List<Episode> episodes = await _loadEpisodes();

    final interestingCharacter = await characterRepo
        .getAll("${Endpoint.getAllCharacter}/${favorites.take(3).join(',')}");

    emit(state.copyWith(
      status: BlocStatus.success,
      episodes: List.of(state.episodes)..addAll(episodes),
      interestingCharacters: interestingCharacter,
    ));
  }

  Future<List<Episode>> _loadEpisodes() async {
    final episodes = <Episode>[];

    await Future.forEach(
        state.character.episodes,
        (String episodeUrl) async =>
            episodes.add(await episodeRepo.get(episodeUrl)));
    return episodes;
  }
}
