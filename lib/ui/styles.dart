import 'styles_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final TextStyle appBarTitle = GoogleFonts.sansita(
    fontSize: SizeConfig.textMultiplier * 5.5,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle drawerTextStyle = GoogleFonts.sansita(
    fontSize: SizeConfig.textMultiplier * 3,
    color: Colors.black,
  );

  static final TextStyle listCardTitle = GoogleFonts.sansita(
    fontSize: SizeConfig.textMultiplier * 3,
    letterSpacing: 2,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle listCardSubtitle = GoogleFonts.assistant(
    fontSize: SizeConfig.textMultiplier * 1.5,
    fontWeight: FontWeight.w800,
  );

  static final double appBarHeight = SizeConfig.textMultiplier * 15;
}
