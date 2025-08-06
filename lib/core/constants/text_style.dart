import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KtextStyle {
  static final heading = GoogleFonts.dancingScript(
    fontSize: 34,
    color: Colors.white,

    fontWeight: FontWeight.bold,
  );

  static final normaltext = GoogleFonts.aBeeZee(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final subHeadings = GoogleFonts.anekOdia(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final forget = GoogleFonts.anekOdia(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: const Color.fromARGB(160, 159, 159, 159),
  );
  static final questionStyle = GoogleFonts.golosText(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final answerStyle = GoogleFonts.anaheim(
    fontSize: 16,
    color: Colors.white,

    fontWeight: FontWeight.bold,
  );

  static final roboto = GoogleFonts.arimo(
    fontSize: 16,

    color: Colors.blueAccent,
    fontWeight: FontWeight.bold,
  );
}
