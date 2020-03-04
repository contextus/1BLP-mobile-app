import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
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
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[200],
    textTheme: TextTheme(
      display4: GoogleFonts.sourceSansPro(fontSize: 104, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      display3: GoogleFonts.sourceSansPro(fontSize: 65, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      display2: GoogleFonts.sourceSansPro(fontSize: 52, fontWeight: FontWeight.w400),
      display1: GoogleFonts.sourceSansPro(fontSize: 37, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline: GoogleFonts.sourceSansPro(fontSize: 26, fontWeight: FontWeight.w400),
      title: GoogleFonts.sourceSansPro(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subhead: GoogleFonts.sourceSansPro(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      subtitle: GoogleFonts.sourceSansPro(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      body1: GoogleFonts.sourceSansPro(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      body2: GoogleFonts.sourceSansPro(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      button: GoogleFonts.sourceSansPro(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      caption: GoogleFonts.sourceSansPro(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline: GoogleFonts.sourceSansPro(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    ),
  );
}
