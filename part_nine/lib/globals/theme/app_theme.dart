import 'package:flutter/material.dart';

final ThemeData asthaTutorialTheme = _asthaTutorialTheme();

//Define Base theme for app
ThemeData _asthaTutorialTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: const Color.fromARGB(255, 255, 153, 51),
      onPrimary: Colors.white,
      secondary: const Color.fromARGB(255, 223, 27, 12),
      onSecondary: Colors.white,
      error: Colors.red,
      background: const Color.fromARGB(255, 228, 243, 228),
      onBackground: Colors.black,
    ),
    textTheme: _asthaTutorialTextTheme(base.textTheme),
    // below text theme add this
    // Define styles for elevated button
    elevatedButtonTheme: _elevatedButtonTheme(base.elevatedButtonTheme),

    // Set Themes for Input
    inputDecorationTheme: _inputDecorationTheme(base.inputDecorationTheme),
    // Define styles for text button
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 223, 27, 12),
        ),
      ),
    ),
  );
}

// Outside of _asthaTutorialTheme function  create another function

TextTheme _asthaTutorialTextTheme(TextTheme base) => base.copyWith(
// This'll be our appbars title
      headline1: base.headline1!.copyWith(
          fontFamily: "Proxima Nova Rg Regular",
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.white),
// for widgets heading/title
      headline2: base.headline2!.copyWith(
        fontFamily: "Proxima Nova Rg Regular",
        fontSize: 26,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
// for sub-widgets heading/title
      headline3: base.headline3!.copyWith(
        fontFamily: "Proxima Nova Rg Regular",
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
// for widgets contents/paragraph
      bodyText1: base.bodyText1!.copyWith(
          fontFamily: "Proxima Nova Rg Regular",
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Colors.black),
// for sub-widgets contents/paragraph
      bodyText2: base.bodyText2!.copyWith(
          fontFamily: "Proxima Nova Rg Regular",
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.black),
    );

InputDecorationTheme _inputDecorationTheme(InputDecorationTheme base) =>
    const InputDecorationTheme(
// Label color for the input widget
      labelStyle: TextStyle(color: Colors.black),
// Define border of input form while focused on
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
      ),
    );

ElevatedButtonThemeData _elevatedButtonTheme(ElevatedButtonThemeData base) =>
    ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 223, 27, 12),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );
