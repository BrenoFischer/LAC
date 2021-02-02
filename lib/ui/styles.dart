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

  static final double appBarHeight = SizeConfig.textMultiplier * 15;
}
