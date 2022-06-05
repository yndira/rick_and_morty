import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/application/character_list_bloc.dart';

import '../domain/character.dart';

class Filters extends StatelessWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildNameFilter(context, state),
                const SizedBox(width: 8),
                _buildOtherFilters(context, state)
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded _buildNameFilter(BuildContext context, CharacterListState state) {
    return Expanded(
      child: TextFormField(
        initialValue: state.name,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: "Buscar personaje...",
          hintStyle: TextStyle(color: Colors.white, fontSize: 12),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          contentPadding: EdgeInsetsDirectional.only(
            start: 16,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        ),
        onChanged: (value) {
          if (value != state.name) {
            context
                .read<CharacterListBloc>()
                .add(CharacterListEvent.nameChanged(value));
          }
        },
        onFieldSubmitted: (value) {
          context
              .read<CharacterListBloc>()
              .add(CharacterListEvent.nameChanged(value));
        },
      ),
    );
  }

  PopupMenuButton<dynamic> _buildOtherFilters(
      BuildContext context, CharacterListState state) {
    return PopupMenuButton(
      offset: const Offset(0, 40),
      icon: const Icon(Icons.list),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: Text("Estado", style: TextStyle(color: Colors.black)),
          ),
          ..._buildStatusPopupMenuItem(context, state),
          const PopupMenuItem(
            child: Text("Género", style: TextStyle(color: Colors.black)),
          ),
          ..._buildGenderPopupMenuItem(context, state),
        ];
      },
    );
  }

  List<PopupMenuItem<dynamic>> _buildStatusPopupMenuItem(
      BuildContext context, CharacterListState state) {
    return Status.values
        .map((status) => PopupMenuItem(
              child: StatefulBuilder(
                builder: (_context, _setState) {
                  return RadioListTile<Status>(
                    groupValue: state.status,
                    value: status,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (value) {
                      context
                          .read<CharacterListBloc>()
                          .add(CharacterListEvent.statusChecked(status));
                      Navigator.of(context).pop();
                    },
                    title: Text(
                      status.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ))
        .toList();
  }

  List<PopupMenuItem<dynamic>> _buildGenderPopupMenuItem(
      BuildContext context, CharacterListState state) {
    return Gender.values
        .map((gender) => PopupMenuItem(
              child: StatefulBuilder(
                builder: (_context, _setState) {
                  return RadioListTile<Gender>(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: gender,
                    groupValue: state.gender,
                    onChanged: (value) {
                      context
                          .read<CharacterListBloc>()
                          .add(CharacterListEvent.genderChecked(gender));
                      Navigator.of(context).pop();
                    },
                    title: Text(
                      gender.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ))
        .toList();
  }
}
