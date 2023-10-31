import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TourShimmer extends StatelessWidget {
  const TourShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemExtent: null,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Container(
                  width: 150,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                Container(
                  width: 50,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                Container(
                  width: 40,
                  height: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ); // Create a widget to display each tour item
      },
    );
  }
}
