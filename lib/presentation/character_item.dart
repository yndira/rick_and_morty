
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';
import 'package:rick_and_morty/domain/character.dart';
import 'package:rick_and_morty/presentation/character_detail.dart';
import 'package:rick_and_morty/presentation/favorite_button.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () => _onTap(context),
  //     child: Card(
  //       elevation: 1.0,
  //       color: Colors.white,
  //       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           SizedBox(
  //             width: 100.0,
  //             height: 100.0,
  //             child: Image.network(character.image),
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Row(
  //                   children: <Widget>[
  //                     Expanded(
  //                       child: Container(
  //                         margin:
  //                             const EdgeInsets.only(top: 12.0, bottom: 10.0),
  //                         child: Text(
  //                           character.name,
  //                           style: const TextStyle(
  //                             fontSize: 18.0,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       margin: const EdgeInsets.only(right: 10.0),
  //                       child: Text(
  //                         character.type,
  //                         style: TextStyle(
  //                             fontSize: 16.0,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.grey[600]),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   margin: const EdgeInsets.only(right: 10.0),
  //                   child: Text(
  //                     character.status.name,
  //                     style: const TextStyle(
  //                       fontSize: 16.0,
  //                     ),
  //                     maxLines: 3,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: const EdgeInsets.only(top: 10.0),
  //                   child: Row(
  //                     children: <Widget>[
  //                       Text(
  //                         "RELEASED",
  //                         style: TextStyle(
  //                           color: Colors.grey[500],
  //                           fontSize: 11.0,
  //                         ),
  //                       ),
  //                       Container(
  //                           margin: const EdgeInsets.only(left: 5.0),
  //                           child: Text(character.name)),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {_onTap(context)},
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.grey,
                width: 1,
              )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 155.0,
                height: 160.0,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      character.image,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                        bottom: 5,
                        right: -15,
                        child: FavoriteButton(
                          onPressed: () => context
                              .read<CharacterListBloc>()
                              .add(CharacterListEvent.favoriteToggled(
                                  character)),
                          disable: !character.favorite,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildCharacterTexts(
                      "${character.status.name} - ${character.species}",
                      character.name,
                      withMark: true,
                    ),
                    _buildCharacterTexts(
                        "Last know location", character.location.name),
                    _buildCharacterTexts(
                        "First seen in", character.episodes.first),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _onTap(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CharacterDetailProvider(character: character)),
    );
  }

  Widget _buildCharacterTexts(
    String text1,
    String text2, {
    bool withMark = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              if (withMark) ...[
                const Icon(
                  Icons.circle,
                  color: Colors.greenAccent,
                  size: 10,
                ),
                const SizedBox(width: 5),
              ],
              Text(text1),
            ],
          ),
          Text(text2),
        ],
      ),
    );
  }
}
