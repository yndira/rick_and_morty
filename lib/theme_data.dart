import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildThemeData() {
  final themeData = ThemeData(useMaterial3: false);

  var colorScheme = themeData.colorScheme.copyWith(
    primary: const Color.fromRGBO(8, 31, 50, 1),
  );

  return themeData.copyWith(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(),
      appBarTheme: _buildAppBarTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      iconTheme: _buildIconThemeData(),
      elevatedButtonTheme: _buildElevatedButtonThemeData());
}

ElevatedButtonThemeData _buildElevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromRGBO(18, 85, 95, 1)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        )),
  );
}

IconThemeData _buildIconThemeData() {
  return const IconThemeData(
    color: Colors.white,
  );
}

InputDecorationTheme _buildInputDecorationTheme() {
  const outlineInputBorder1 = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
      width: 2,
    ),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );
  return const InputDecorationTheme(
    enabledBorder: outlineInputBorder1,
    disabledBorder: outlineInputBorder1,
    focusedBorder: outlineInputBorder1,
    // fillColor: AppColors.primaryContainer,
    filled: true,

    // suffixIconColor: AppColors.suffixIconColor,
  );
}

AppBarTheme _buildAppBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: Colors.white),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 22,
    ),
  );
}

TextTheme _buildTextTheme() {
  return GoogleFonts.montserratTextTheme(
    const TextTheme(
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
