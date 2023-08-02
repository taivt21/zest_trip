import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.iconData = Icons.add,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
