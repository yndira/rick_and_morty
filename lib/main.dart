import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';
import 'package:rick_and_morty/presentation/character_list.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/repositories/episode_repository.dart';
import 'package:rick_and_morty/services/api_service.dart';
import 'package:rick_and_morty/theme_data.dart';

import 'application/simple_bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  static final apiService = ApiService();
  static final characterRepo = CharacterRepository(apiService);
  static final episodeRepo = EpisodeRepository(apiService);

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildThemeData(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterListBloc>(
          create: (context) => CharacterListBloc(
            MyApp.characterRepo,
            MyApp.episodeRepo,
          )..add(const CharacterListEvent.characterFetched()),
        ),
      ],
      child: const CharacterList(),
    );
  }
}
