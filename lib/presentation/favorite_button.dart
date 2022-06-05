import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool disable;

  const FavoriteButton(
      {Key? key, required this.onPressed, required this.disable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 3,
      color: Colors.grey[50],
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.star,
          color: disable ? Colors.grey : Colors.yellow,
        ),
      ),
    );
  }
}
