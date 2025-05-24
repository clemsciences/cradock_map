


import "package:cradock_map/style/style.dart";
import "package:flutter/material.dart";

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: SatStyle.lightBlueColor,
      // ···
      brightness: Brightness.light,
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      // ···
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: SatStyle.redColor,
      ),
      titleLarge: TextStyle(
        fontSize: 30,
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: TextStyle(),
      displaySmall: TextStyle(),
    ),
  );
}