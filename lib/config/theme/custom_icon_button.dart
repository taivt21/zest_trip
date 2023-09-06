import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final double buttonHeight;
  final Color iconColor;

  const IconButtonCustom({
    super.key,
    required this.iconData,
    required this.onPressed,
    this.buttonHeight = 42,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
      iconSize: buttonHeight,
      color: iconColor,
    );
  }
}
