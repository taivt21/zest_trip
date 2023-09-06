import 'package:flutter/material.dart';

class TextButtonCustom extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final double buttonHeight;
  final Color textColor;

  const TextButtonCustom({
    super.key,
    required this.text,
    this.iconData,
    required this.onPressed,
    this.buttonHeight = 42,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, buttonHeight),
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
