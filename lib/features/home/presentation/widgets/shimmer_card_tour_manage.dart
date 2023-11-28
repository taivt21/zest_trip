import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardTourManage extends StatelessWidget {
  final double width;

  const ShimmerCardTourManage({Key? key, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 100,
                      height: 16,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 16,
                  color: Colors.grey[300],
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 100,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 200,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 80,
                    width: width, // Thay đổi kích thước ngang ở đây
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                        Container(
                          width: 80,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    Container(
                      width: 120,
                      height: 16,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 32,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 80,
                      height: 32,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
