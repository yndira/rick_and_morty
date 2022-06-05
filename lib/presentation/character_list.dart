import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/styles.dart';

import '../application/character_list_bloc.dart';
import 'bottom_app.dart';
import 'character_item.dart';
import 'character_list_empty.dart';
import 'favorite_button.dart';
import 'filters.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final _scrollController = ScrollController();
  late final CharacterListBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _characterBloc = context.read<CharacterListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterListBloc, CharacterListState>(
        listener: (context, state) {
      if (state.blocStatus == BlocStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Parece que has perdido tu viaje. \n Ha ocurrido un error."),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: _buildCustomScrollView(state, context),
      );
    });
  }

  CustomScrollView _buildCustomScrollView(
      CharacterListState state, BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: const Filters(),
            background: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _buildShowFavoritesButton(context, state),
        ),
        _buildList(state),
        if (state.blocStatus == BlocStatus.loading &&
            state.characters.isNotEmpty &&
            !state.hasReachedMax)
          _buildCircularProgress(state),
        if (state.blocStatus != BlocStatus.loading &&
            (state.hasReachedMax || state.characters.isEmpty))
          const SliverToBoxAdapter(
            child: BottomApp(),
          ),
      ],
    );
  }

  Widget _buildCircularProgress(CharacterListState state) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      )),
    );
  }

  Widget _buildList(CharacterListState state) {
    if ((state.blocStatus == BlocStatus.initial ||
            state.blocStatus == BlocStatus.loading) &&
        state.characters.isEmpty) {
      return _buildCircularProgress(state);
    } else {
      if (state.characters.isEmpty) {
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: CharacterListEmpty(),
        );
      } else {
        return _buildItems(state);
      }
    }
  }

  SliverList _buildItems(CharacterListState state) {
    final characters =
        state.showFavorites ? state.characters : state.charactersFavorites;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CharacterItem(
            character: characters[index],
            show: true,
          );
        },
        childCount: characters.length,
      ),
    );
  }

  Padding _buildShowFavoritesButton(
      BuildContext context, CharacterListState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "Mostrar favoritos",
            style: regularMediumTextStyle.copyWith(fontSize: 18),
          ),
          FavoriteButton(
            onPressed: () => state.showFavorites
                ? _characterBloc.add(const CharacterListEvent.favoritesShowed())
                : _characterBloc.add(const CharacterListEvent.favoritesHid()),
            disable: state.showFavorites,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _characterBloc.add(const CharacterListEvent.characterFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.90);
  }
}
