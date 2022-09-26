import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColorDark = Color(0xFF000000);
const primaryColor = Color(0xFF171717);
const primaryColorLight = Color(0xFF262626);
const secondary = Color(0xFFDBB807);

final ThemeData themeData = ThemeData();

final defaultTheme = themeData.copyWith(
  appBarTheme: themeData.appBarTheme.copyWith(
    backgroundColor: Colors.white,
    foregroundColor: primaryColorDark,
  ),
  textTheme: GoogleFonts.montserratTextTheme(themeData.textTheme).copyWith(
    bodyText1: const TextStyle(
      fontSize: 18.0,
      color: Colors.black,
    ),
    bodyText2: const TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
    button: const TextStyle(
      fontSize: 18.0,
      color: Colors.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(200, 50),
      maximumSize: const Size(300, 50),
      primary: primaryColorDark,
      onPrimary: Colors.white,
    ),
  ),
  primaryColorDark: primaryColorDark,
  primaryColorLight: primaryColorLight,
  primaryColor: primaryColor,
  colorScheme: themeData.colorScheme.copyWith(secondary: secondary),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
