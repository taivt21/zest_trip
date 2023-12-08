import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardTourManage extends StatelessWidget {
  const ShimmerCardTourManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        height: 200,
        width: double.infinity,
      ),
    );
  }
}
