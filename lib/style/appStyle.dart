import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgcolor = Color(0xffffffff);
  static Color maincolor = Color.fromARGB(255, 23, 2, 59);
  static Color accentcolor = Colors.blue;

  // card colors
  static List<Color> cardsColor = [
    Colors.white,
    Colors.red,
    Colors.brown,
    Colors.green,
    Colors.pink,
    Colors.cyanAccent,
  ];
  // text style
  static TextStyle mainTitle =
      GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle mainContent =
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.normal);
  static TextStyle dateTitle =
      GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.normal);
}
