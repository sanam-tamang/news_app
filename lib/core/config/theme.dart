import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/config/pallet.dart';

class NewsTheme {
  static ThemeData lightMode() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: NewsAppPallet.baseColor,
      
      primaryContainer: NewsAppPallet.containerColor,

      onPrimaryContainer: NewsAppPallet.whiteTextColor,

      
      ),


      textTheme: GoogleFonts.latoTextTheme(

        TextTheme(
                 
        )
      )
    );
  }
}
