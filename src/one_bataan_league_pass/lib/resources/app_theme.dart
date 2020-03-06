import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_theme.dart';

class AppTheme {
  static final materialDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(
      4280361248,
      {
        50: Color(0xfff2f2f2),
        100: Color(0xffe6e6e5),
        200: Color(0xffcdcdcb),
        300: Color(0xffb4b4b1),
        400: Color(0xff9b9b97),
        500: Color(0xff81817e),
        600: Color(0xff686864),
        700: Color(0xff4e4e4b),
        800: Color(0xff343432),
        900: Color(0xff1a1a19)
      },
    ),
    accentColor: Colors.white,
    canvasColor: Color(0xff343432),
    cardColor: Color(0xff343432),
    scaffoldBackgroundColor: Color(0xff1a1a19),
    colorScheme: ColorScheme(
      primary: Color(0xff9b9b97),
      primaryVariant: Color(0xff686864),
      secondary: Colors.white,
      secondaryVariant: Colors.white70,
      surface: Color(0xff4e4e4b),
      background: Color(0xff1a1a19),
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      display4: GoogleFonts.sourceSansPro(
        fontSize: 104,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      display3: GoogleFonts.sourceSansPro(
        fontSize: 65,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      display2: GoogleFonts.sourceSansPro(
        fontSize: 52,
        fontWeight: FontWeight.w400,
      ),
      display1: GoogleFonts.sourceSansPro(
        fontSize: 37,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline: GoogleFonts.sourceSansPro(
        fontSize: 26,
        fontWeight: FontWeight.w400,
      ),
      title: GoogleFonts.sourceSansPro(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subhead: GoogleFonts.sourceSansPro(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle: GoogleFonts.sourceSansPro(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      body1: GoogleFonts.sourceSansPro(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: appDarkColorTheme.primaryTextColor,
      ),
      body2: GoogleFonts.sourceSansPro(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.sourceSansPro(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: GoogleFonts.sourceSansPro(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: appDarkColorTheme.tertiaryTextColor,
      ),
      overline: GoogleFonts.sourceSansPro(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderColor: Colors.white54,
      selectedBorderColor: Colors.white,
      selectedColor: Colors.white,
      color: Colors.white54,
      fillColor: Color(0xff1a1a19),
      borderRadius: BorderRadius.circular(2),
    ),
  );

  static final materialLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    accentColor: Color(0xff82cb04),
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[200],
    colorScheme: ColorScheme(
      primary: Colors.white,
      primaryVariant: Colors.white,
      secondary: Color(0xff82cb04),
      secondaryVariant: Color(0xff82cb04),
      surface: Colors.white,
      background: Colors.grey[200],
      error: Colors.red,
      onPrimary: Color(0xff1d1d1f),
      onSecondary: Colors.white,
      onSurface: Color(0xff1d1d1f),
      onBackground: Color(0xff1d1d1f),
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    canvasColor: Colors.white,
    cardColor: Colors.white,
    textTheme: TextTheme(
      display4: GoogleFonts.sourceSansPro(
        fontSize: 104,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      display3: GoogleFonts.sourceSansPro(
        fontSize: 65,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      display2: GoogleFonts.sourceSansPro(
        fontSize: 52,
        fontWeight: FontWeight.w400,
      ),
      display1: GoogleFonts.sourceSansPro(
        fontSize: 37,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline: GoogleFonts.sourceSansPro(
        fontSize: 26,
        fontWeight: FontWeight.w400,
      ),
      title: GoogleFonts.sourceSansPro(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subhead: GoogleFonts.sourceSansPro(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle: GoogleFonts.sourceSansPro(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      body1: GoogleFonts.sourceSansPro(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: appLightColorTheme.primaryTextColor,
      ),
      body2: GoogleFonts.sourceSansPro(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.sourceSansPro(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: GoogleFonts.sourceSansPro(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: appLightColorTheme.tertiaryTextColor,
      ),
      overline: GoogleFonts.sourceSansPro(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderColor: Color(0xff82cb04),
      selectedBorderColor: Color(0xff82cb04),
      fillColor: Color(0xff82cb04),
      borderRadius: BorderRadius.circular(2),
    ),
  );

  static final appLightColorTheme = AppColorTheme(
    activeIconColor: Color(0xff515154),
    inactiveIconColor: Color(0x9b9c9c9e),
    primaryTextColor: Color(0xff1d1d1f),
    secondaryTextColor: Color(0xff515154),
    tertiaryTextColor: Color(0xff86868b),
    shimmerBaseColor: Colors.grey[200],
    shimmerHighLightColor: Colors.grey[50],
  );

  static final appDarkColorTheme = AppColorTheme(
    activeIconColor: Colors.white,
    inactiveIconColor: Colors.white24,
    primaryTextColor: Colors.white,
    secondaryTextColor: Colors.white70,
    tertiaryTextColor: Colors.white54,
    shimmerBaseColor: Colors.grey[800],
    shimmerHighLightColor: Colors.grey[850],
  );
}
