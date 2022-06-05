import 'package:flutter/material.dart';

class BottomApp extends StatelessWidget {
  const BottomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bottom.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
