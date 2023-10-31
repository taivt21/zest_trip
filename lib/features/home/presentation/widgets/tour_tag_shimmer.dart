import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TourTagShimmer extends StatelessWidget {
  const TourTagShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: FilterChip(
        avatar: CircleAvatar(
          backgroundColor: Colors.grey[300]!,
          radius: 12.0,
        ),
        label: Container(
          height: 16.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[300]!,
          ),
        ),
        onSelected: (_) {},
      ),
    );
  }
}
