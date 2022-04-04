import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Map<int, Color> themeColor = {
  50: const Color.fromRGBO(218, 41, 28, .1),
  100: const Color.fromRGBO(218, 41, 28, .2),
  200: const Color.fromRGBO(218, 41, 28, .3),
  300: const Color.fromRGBO(218, 41, 28, .4),
  400: const Color.fromRGBO(218, 41, 28, .5),
  500: const Color.fromRGBO(218, 41, 28, .6),
  600: const Color.fromRGBO(218, 41, 28, .7),
  700: const Color.fromRGBO(218, 41, 28, .8),
  800: const Color.fromRGBO(218, 41, 28, .9),
  900: const Color.fromRGBO(218, 41, 28, 1),
  //900: const Color.fromRGBO(90, 23, 238, 1),
};

final theme = ThemeData(
  primaryColor: MaterialColor(0xFFDA291C, themeColor),
  fontFamily: GoogleFonts.montserrat().fontFamily,
  inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: MaterialColor(0xFFDA291C, themeColor),
    accentColor: themeColor[900],
  ).copyWith(secondary: MaterialColor(0xFFDA291C, themeColor)),
);
