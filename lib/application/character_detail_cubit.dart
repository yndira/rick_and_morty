import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';
import 'package:rick_and_morty/domain/Episode.dart';

import '../domain/character.dart';
import '../repositories/episode_repository.dart';

part 'character_detail_state.dart';

part 'character_detail_cubit.freezed.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  final EpisodeRepository repo;

  CharacterDetailCubit(Character character, this.repo)
      : super(CharacterDetailState.initial(character));

  Future<void> loadEpisodes() async {
    emit(state.copyWith(status: BlocStatus.loading));
    final episodes = <Episode>[];

    await Future.forEach(state.character.episodes,
        (String episodeUrl) async => episodes.add(await repo.get(episodeUrl)));

    emit(state.copyWith(
      status: BlocStatus.success,
      episodes: List.of(state.episodes)..addAll(episodes),
    ));

    //Todo: falta tratamiento de errores
  }
}
