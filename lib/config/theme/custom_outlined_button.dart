import 'package:flutter/material.dart';

class OutlinedButtonCustom extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final double buttonHeight;
  final Color textColor;
  final Color borderColor;

  const OutlinedButtonCustom({
    super.key,
    required this.text,
    this.iconData,
    required this.onPressed,
    this.buttonHeight = 42,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, buttonHeight),
        side: BorderSide(color: borderColor),
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
