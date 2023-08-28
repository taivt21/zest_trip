import 'package:flutter/material.dart';

class CustomScrollTabBar extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<int> onTabChanged;

  const CustomScrollTabBar({
    super.key,
    required this.categories,
    required this.onTabChanged,
  });

  @override
  _CustomScrollTabBarState createState() => _CustomScrollTabBarState();
}

class _CustomScrollTabBarState extends State<CustomScrollTabBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories
            .asMap()
            .map(
              (index, category) => MapEntry(
                index,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onTabChanged(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color:
                            _selectedIndex == index ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
