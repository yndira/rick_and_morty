import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/application/character_detail_cubit.dart';
import 'package:rick_and_morty/domain/Episode.dart';
import 'package:rick_and_morty/presentation/character_item.dart';

import '../domain/character.dart';
import '../main.dart';

class CharacterDetailProvider extends StatelessWidget {
  final Character character;

  const CharacterDetailProvider({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("BUILD CharacterDetailProvider");

    return BlocProvider<CharacterDetailCubit>(
      create: (context) =>
          CharacterDetailCubit(character, MyApp.episodeRepo)..loadEpisodes(),
      child: CharacterDetail(),
    );
  }
}

class CharacterDetail extends StatelessWidget {
  final bodyPadding = 8.0;
  final cardInfoPadding = 8.0;
  double minSizeCard = 0;

  @override
  Widget build(BuildContext context) {
    // return _buildBody(context);

    print("BUILD CharacterDetail");

    final width = MediaQuery.of(context).size.width;
    print("WIDTH: ${width / 2 - bodyPadding - cardInfoPadding}");
    minSizeCard = width / 2 - bodyPadding - cardInfoPadding;

    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      builder: (context, state) {
        return _buildScaffold(context, state);
        // return Scaffold(
        //   appBar: AppBar(
        //     toolbarHeight: 150,
        //     // title: Text(
        //     //   character.name,
        //     // ),
        //
        //     flexibleSpace: Stack(
        //       children: [
        //         Positioned.fill(
        //           child: Column(
        //             children: [
        //               Expanded(
        //                 child: Container(
        //                   alignment: Alignment.topCenter,
        //                   decoration: const BoxDecoration(
        //                     image: DecorationImage(
        //                       image: AssetImage(
        //                           "assets/images/background_detail.png"),
        //                       fit: BoxFit.cover,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               Expanded(
        //                 child: Container(
        //                   height: 60,
        //                   alignment: Alignment.topCenter,
        //                   decoration: const BoxDecoration(
        //                     color: Colors.purple,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Positioned.fill(
        //           child: Align(
        //             alignment: Alignment.center,
        //             child: CircleAvatar(
        //               radius: 50,
        //               backgroundColor: Colors.white,
        //               backgroundImage: NetworkImage(state.character.image),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     backgroundColor: Colors.lightBlue,
        //     elevation: 0,
        //   ),
        //   body: _buildBody(context, state),
        // );
      },
    );
  }

  Widget _buildScaffold(BuildContext context, CharacterDetailState state) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 300.0,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background_detail.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 100.0,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: ClipRRect(
                          child: Image(
                            image: NetworkImage(state.character.image),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.greenAccent,
                            size: 10,
                          ),
                          Text(state.character.status.name),
                        ],
                      ),
                      Text(
                        state.character.name,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        state.character.type,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(child: _buildBody(context, state)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, CharacterDetailState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Información"),
            Wrap(
              children: [
                _buildInfo("Gender", state.character.gender.name),
                _buildInfo("Origin", state.character.origin.name),
                _buildInfo("Type", state.character.type),
              ],
            ),
            const Divider(thickness: 1),
            _buildInfoEpisodes(state),
            const Divider(thickness: 1),
            _buildPersonajesInteresantes(state),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoEpisodes(CharacterDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Episodios"),
        Wrap(
          children: [...state.episodes.map((e) => _buildInfoEpisode(e))],
        ),
      ],
    );
  }

  Widget _buildInfo(String title, String text) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSizeCard,
        maxWidth: minSizeCard,
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
                Text(title),
              ],
            ),
            Text(text)
          ],
        ),
      ),
    );
  }

  Widget _buildInfoEpisode(Episode episode) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minSizeCard,
        maxWidth: minSizeCard,
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
            Text(episode.name),
            Text(episode.episode),
            Text(episode.airDate),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonajesInteresantes(CharacterDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Personajes interesantes"),
        Wrap(
          children: [
            ...state.episodes
                .map((e) => CharacterItem(character: state.character))
          ],
        ),
      ],
    );
  }
}
