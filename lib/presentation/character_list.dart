import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/character_list_bloc.dart';
import 'character_item.dart';
import 'favorite_button.dart';
import 'filters.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key, required this.title}) : super(key: key);
  final String title;

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
    return BlocBuilder<CharacterListBloc, CharacterListState>(
        builder: (context, state) {
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
          child: SizedBox(
            child: _buildShowFavoritesButton(context, state),
          ),
        ),
        _buildItems(state),
        if (state.status == BlocStatus.loading &&
            state.characters.isNotEmpty &&
            !state.hasReachedMax)
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage("assets/images/bottom.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItems(CharacterListState state) {
    if (state.status == BlocStatus.initial ||
        state.status == BlocStatus.loading && state.characters.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    } else {
      final characters =
          state.showFavorites ? state.characters : state.charactersFavorites;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return CharacterItem(
              character: characters[index],
            );
          },
          childCount: characters.length,
        ),
      );
    }

    // if (state.status == BlocStatus.initial ||
    //     state.status == BlocStatus.loading && state.characters.isEmpty) {
    //   return const Center(child: CircularProgressIndicator());
    // } else {
    //   final characters =
    //       state.showFavorites ? state.characters : state.charactersFavorites;
    //   return Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Flexible(
    //         child: ListView.builder(
    //           // controller: _scrollController,
    //           shrinkWrap: true,
    //           itemCount: characters.length,
    //           itemBuilder: (context, index) {
    //             return CharacterItem(
    //               character: characters[index],
    //             );
    //           },
    //         ),
    //       ),
    //       if (state.status == BlocStatus.loading &&
    //           state.characters.isNotEmpty &&
    //           !state.hasReachedMax)
    //         const Center(child: CircularProgressIndicator())
    //     ],
    //   );
    // }
  }

  Padding _buildShowFavoritesButton(
      BuildContext context, CharacterListState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(state.showFavorites ? "Mostrar favoritos" : "Mostrar todos"),
          FavoriteButton(
            onPressed: () => state.showFavorites
                ? _characterBloc.add(const CharacterListEvent.favoritesShowed())
                : _characterBloc.add(const CharacterListEvent.favoritesHid()),
            disable: !state.showFavorites,
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
    final double height = MediaQuery.of(context).size.height;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.90);
  }
}
