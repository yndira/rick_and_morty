import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildThemeData() {
  final themeData = ThemeData(useMaterial3: false);

  var colorScheme = themeData.colorScheme.copyWith(
      primary: const Color.fromRGBO(8, 31, 50, 1),
      secondary: Colors.red,
      tertiary: Colors.green
      // errorContainer: AppColors.errorContainer,
      // primaryContainer: AppColors.primaryContainer,
      // secondaryContainer: AppColors.secondaryContainer,
      // onSurface: AppColors.onSurface,
      // onSurfaceVariant: AppColors.onSurfaceVariant,
      // outline: AppColors.outline,
      // error: AppColors.error,
      // onPrimary: AppColors.onPrimary,
      );

  return themeData.copyWith(
    colorScheme: colorScheme,
    // disabledColor: AppColors.disabled,
    // toggleableActiveColor: AppColors.primary,
    // floatingActionButtonTheme: _buildFloatingActionButtonThemeData(),
    textTheme: _buildTextTheme(),
    appBarTheme: _buildAppBarTheme(),
    inputDecorationTheme: _buildInputDecorationTheme(),
    iconTheme: _buildIconThemeData(),
    // textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey),
    // bottomNavigationBarTheme: _buildBottomNavigationBarThemeData(),
    // checkboxTheme: _buildCheckboxThemeData(),
    // chipTheme: buildChipThemeData(),
    // scaffoldBackgroundColor: AppColors.secondaryContainer,
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

// ChipThemeData buildChipThemeData() => ChipThemeData(
//       backgroundColor: AppColors.primary95,
//       selectedColor: AppColors.primary,
//       labelStyle:
//           app_text_styles.buttonLarge.copyWith(color: AppColors.onSurface),
//       secondaryLabelStyle:
//           app_text_styles.buttonLarge.copyWith(color: AppColors.onPrimary),
//       showCheckmark: true,
//       checkmarkColor: AppColors.onPrimary,
//     );
//
// CheckboxThemeData _buildCheckboxThemeData() {
//   return CheckboxThemeData(
//       // side: BorderSide(
//       // color: AppColors.secondaryContainer, //your desire colour here
//       // width: 1,
//       // ),
//       // shape: RoundedRectangleBorder(
//       //   borderRadius: BorderRadius.circular(2.0),
//       // ),
//       );
// }
//
// BottomNavigationBarThemeData _buildBottomNavigationBarThemeData() {
//   final textStyle = const TextStyle(fontWeight: FontWeight.w500, fontSize: 11);
//
//   return BottomNavigationBarThemeData(
//     backgroundColor: AppColors.primaryContainer,
//     selectedIconTheme: IconThemeData(color: AppColors.primary),
//     selectedItemColor: AppColors.primary,
//     unselectedItemColor: Colors.grey,
//     selectedLabelStyle: textStyle,
//     unselectedLabelStyle: textStyle,
//     showUnselectedLabels: true,
//     type: BottomNavigationBarType.fixed,
//   );
// }
//
// FloatingActionButtonThemeData _buildFloatingActionButtonThemeData() {
//   return FloatingActionButtonThemeData(
//     backgroundColor: AppColors.primary,
//   );
// }
//
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
      headline1: TextStyle(color: Colors.red),
      headline2: TextStyle(color: Colors.black54),
      headline3: TextStyle(color: Colors.black45),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.purple),
    ),
  );
}
