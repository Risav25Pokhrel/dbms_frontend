import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class MyFont {
  static final TextStyle headline =
      GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.bold);
  static final TextStyle content =
      GoogleFonts.ubuntuCondensed(fontSize: 18, fontWeight: FontWeight.w500);
  static final TextStyle numberplate = GoogleFonts.cormorantGaramond(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
}
