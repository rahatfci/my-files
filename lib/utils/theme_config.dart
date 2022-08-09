import 'package:flutter/material.dart';

class ThemeConfig {
  static Color lightPrimary = Color(0xfff3f4f9);
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff597ef7);
  static Color darkAccent = Color(0xff597ef7);
  static Color lightBG = Color(0xfff3f4f9);
  static Color darkBG = Color(0xff121212);
  static Color backgroundSmokeWhite = Color(0xffB0C6D0).withOpacity(0.1);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: lightPrimary,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightAccent),
  );

  static ThemeData darkTheme = ThemeData(
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: darkPrimary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: darkAccent,
      brightness: Brightness.dark,
    ),
  );
}
