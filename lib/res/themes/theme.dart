import 'package:chat_ai/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Mode
var lightTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      background: lightBGColor,
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      onSecondaryContainer: lightButtonColor,
      secondaryContainer: lightUniqueColor,
      onSurface: lightFlushBar,
      onPrimary: lightTextColor,
    ));

// Dark Mode
var darkTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      background: darkBGColor,
      primary: darkPrimaryColor,
      secondary: darkSecondaryColor,
      onSecondaryContainer: darkButtonColor,
      secondaryContainer: darkUniqueColor,
      onSurface: darkFlushBar,
      onPrimary: darkTextColor,
    ));
