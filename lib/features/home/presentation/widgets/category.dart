import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final Color color;
  final String text;
  const Category({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 48,
      width: (MediaQuery.of(context).size.width - 48 - 20) / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
