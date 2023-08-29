import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';

class CustomScrollTabBar extends StatefulWidget {
  final List<TourTag> categories;
  final ValueChanged<int> onTabChanged;

  const CustomScrollTabBar({
    Key? key,
    required this.categories,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  _CustomScrollTabBarState createState() => _CustomScrollTabBarState();
}

class _CustomScrollTabBarState extends State<CustomScrollTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: List.generate(
              widget.categories.length,
              (index) => Tab(
                child: Text(
                  widget.categories[index].name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // decoration: _selectedIndex == index
                    //     ? TextDecoration.underline
                    //     : TextDecoration.none,
                  ),
                ),
              ),
            ),
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              widget.onTabChanged(index);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: List.generate(
                widget.categories.length,
                (index) => Center(
                  child: Text(
                    'Content for ${widget.categories[index].name}',
                    style: AppTextStyles.headline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
