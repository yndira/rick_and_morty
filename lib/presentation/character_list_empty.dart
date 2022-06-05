import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/styles.dart';

class CharacterListEmpty extends StatelessWidget {
  const CharacterListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Uh-oh!",
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontFamily: "montserrat"),
            ),
            const Text(
              "Pareces perdido en tu viaje",
              style: regularSmallTextStyle,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Eliminar filtros"),
            ),
          ],
        ),
      ),
    );
  }
}
