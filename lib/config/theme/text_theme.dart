import 'package:flutter/material.dart';

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

  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}
