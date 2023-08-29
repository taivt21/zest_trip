import 'package:flutter/material.dart';

// class ZTextTheme {
//   static TextTheme lightTextTheme = TextTheme(
//       displayMedium: GoogleFonts.montserrat(
//         color: Colors.white70,
//       ),
//       titleSmall: GoogleFonts.poppins(color: Colors.white60, fontSize: 24));
//   static TextTheme darkTextTheme = TextTheme(
//       displayMedium: GoogleFonts.montserrat(
//         color: Colors.black87,
//       ),
//       titleSmall: GoogleFonts.poppins(color: Colors.black54, fontSize: 24));
// }

class AppTextStyles {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle title = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 12,
  );
}
