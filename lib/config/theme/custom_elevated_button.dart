import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final double buttonHeight;
  final Color textColor;
  final Color backgroundColor;

  const ElevatedButtonCustom({
    super.key,
    required this.text,
    this.iconData,
    required this.onPressed,
    this.buttonHeight = 42,
    this.textColor = Colors.white,
    this.backgroundColor = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(double.infinity, buttonHeight),
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null) Icon(iconData),
          if (iconData != null) const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
