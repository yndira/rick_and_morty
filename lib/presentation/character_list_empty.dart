import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/styles.dart';

import '../application/character_list_bloc.dart';

class CharacterListEmpty extends StatelessWidget {
  const CharacterListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Uh-oh!",
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 30,
              fontWeight: FontWeight.w600,
              fontFamily: "montserrat"),
        ),
        const SizedBox(height: 16),
        const Text(
          "Pareces perdido en tu viaje",
          style: regularSmallTextStyle,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context
                .read<CharacterListBloc>()
                .add(const CharacterListEvent.filtersDeleted());
          },
          child: const Text("Eliminar filtros"),
        ),
      ],
    );
  }
}
