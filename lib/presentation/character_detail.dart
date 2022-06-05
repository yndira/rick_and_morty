import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/application/character_detail_cubit.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';
import 'package:rick_and_morty/domain/Episode.dart';
import 'package:rick_and_morty/presentation/character_item.dart';
import 'package:rick_and_morty/presentation/styles.dart';

import '../domain/character.dart';
import '../main.dart';

class CharacterDetailProvider extends StatelessWidget {
  final Character character;

  const CharacterDetailProvider({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterDetailCubit>(
      create: (context) => CharacterDetailCubit(
          character, MyApp.episodeRepo, MyApp.characterRepo)
        ..load(),
      child: CharacterDetail(),
    );
  }
}

class CharacterDetail extends StatelessWidget {
  const CharacterDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CharacterHeaderAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              urlImage:
                  context.read<CharacterDetailCubit>().state.character.image,
            ),
            pinned: false,
          ),
          SliverAppBar(
            automaticallyImplyLeading: true,
            pinned: true,
            expandedHeight: 100.0,
            collapsedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 1,
              title: _buildCharacterHeader(context),
              background: Container(),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterHeader(BuildContext context) {
    final state = context.read<CharacterDetailCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.circle,
              color: Colors.greenAccent,
              size: 10,
            ),
            const SizedBox(width: 5),
            Text(
              state.character.status.name.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          state.character.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          state.character.species.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoCharcater(context, state),
              const Divider(thickness: 1),
              if (state.status == BlocStatus.loading)
                Center(child: CircularProgressIndicator()),
              if (state.status != BlocStatus.loading) ...[
                _buildInfoEpisodes(context, state),
                const Divider(thickness: 1),
                _buildPersonajesInteresantes(state),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCharcater(BuildContext context, CharacterDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Información",
          style: sectionTextStyle,
        ),
        Wrap(
          children: [
            _buildInfo(context, "Gender", state.character.gender.name),
            _buildInfo(context, "Origin", state.character.origin.name),
            _buildInfo(context, "Type", state.character.type),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoEpisodes(BuildContext context, CharacterDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Episodios",
          style: sectionTextStyle,
        ),
        Wrap(
          children: [
            ...state.episodes.map((e) => _buildInfoEpisode(context, e))
          ],
        ),
      ],
    );
  }

  Widget _buildInfo(BuildContext context, String title, String text) {
    final width = MediaQuery.of(context).size.width / 2 - 12;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width,
        maxWidth: width,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: _titleInfoTextStyle(),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: _subtitleInfoTextStyle(),
            )
          ],
        ),
      ),
    );
  }

  TextStyle _subtitleInfoTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "montserrat",
    );
  }

  TextStyle _titleInfoTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w300,
      fontFamily: "montserrat",
    );
  }

  Widget _buildInfoEpisode(BuildContext context, Episode episode) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 2 - 12,
        maxWidth: MediaQuery.of(context).size.width / 2 - 12,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              episode.name,
              style: _titleInfoTextStyle(),
            ),
            const SizedBox(height: 3),
            Text(
              episode.episode,
              style: _subtitleInfoTextStyle(),
            ),
            const SizedBox(height: 8),
            Text(
              episode.airDate,
              style: _titleInfoTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonajesInteresantes(CharacterDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Personajes interesantes",
          style: sectionTextStyle,
        ),
        Wrap(
          children: [
            ...state.interestingCharacters
                .map((c) => CharacterItem(character: c))
          ],
        ),
      ],
    );
  }
}

class CharacterHeaderAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String urlImage;

  CharacterHeaderAppBar({
    required this.expandedHeight,
    required this.urlImage,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_item.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: expandedHeight / 1.7 - shrinkOffset,
            left: MediaQuery.of(context).size.width / 2 -
                MediaQuery.of(context).size.width / 8,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width / 7.5,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 8,
                backgroundImage: NetworkImage(urlImage),
              ),
            )),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
