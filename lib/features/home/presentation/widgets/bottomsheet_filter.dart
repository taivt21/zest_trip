import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  FilterBottomSheetState createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  RangeValues _priceRange = const RangeValues(0, 1000);
  final List<String> _selectedCategories = [];
  final List<String> _selectedLocations = [];
  RangeValues _durationRange = const RangeValues(1, 30);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter',
          style: AppTextStyles.title,
        ),
        const SizedBox(height: 16),

        // Category Filter
        const Text(
          'Category',
          style: AppTextStyles.headline,
        ),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(
              label: const Text('Beach', style: AppTextStyles.body),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCategories.add('Beach');
                  } else {
                    _selectedCategories.remove('Beach');
                  }
                });
              },
              selected: _selectedCategories.contains('Beach'),
            ),
            FilterChip(
              label: const Text('Forest', style: AppTextStyles.body),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCategories.add('Forest');
                  } else {
                    _selectedCategories.remove('Forest');
                  }
                });
              },
              selected: _selectedCategories.contains('Forest'),
            ),
            // Add more FilterChip widgets for other categories
          ],
        ),
        const SizedBox(height: 16),

        // Price Range Filter
        const Text(
          'Price Range',
          style: AppTextStyles.headline,
        ),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 2000,
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Text(
            'Min: ${_priceRange.start.toStringAsFixed(2)}, Max: ${_priceRange.end.toStringAsFixed(2)}',
            style: AppTextStyles.body),
        const SizedBox(height: 16),

        // Location Filter
        const Text(
          'Location',
          style: AppTextStyles.headline,
        ),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(
              label: const Text('City A', style: AppTextStyles.body),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedLocations.add('City A');
                  } else {
                    _selectedLocations.remove('City A');
                  }
                });
              },
              selected: _selectedLocations.contains('City A'),
            ),
            FilterChip(
              label: const Text('City B', style: AppTextStyles.body),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedLocations.add('City B');
                  } else {
                    _selectedLocations.remove('City B');
                  }
                });
              },
              selected: _selectedLocations.contains('City B'),
            ),
            // Add more FilterChip widgets for other locations
          ],
        ),
        const SizedBox(height: 16),

        // Duration Filter
        const Text(
          'Duration Range (days)',
          style: AppTextStyles.headline,
        ),
        RangeSlider(
          values: _durationRange,
          min: 1,
          max: 30,
          onChanged: (values) {
            setState(() {
              _durationRange = values;
            });
          },
        ),
        Text(
            'Min: ${_durationRange.start.toStringAsFixed(0)}, Max: ${_durationRange.end.toStringAsFixed(0)}',
            style: AppTextStyles.body),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // Apply filter logic and close the bottom sheet
                Navigator.pop(context);
              },
              child: const Text('Clear all', style: AppTextStyles.body),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Apply Filter',
                  style: TextStyle(color: whiteColor)),
            ),
          ],
        ),
      ],
    );
  }
}
