// ignore_for_file: public_member_api_docs, sort_constructors_first
// coupon_widget.dart

import 'package:flutter/material.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_voucher_entity.dart';

class CouponWidget extends StatefulWidget {
  final TourVoucherEntity voucher;
  const CouponWidget({
    Key? key,
    required this.voucher,
  }) : super(key: key);

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ClipPath(
        clipper: DolDurmaClipper(
            holeRadius:
                20), // Sử dụng custom clipper DolDurmaClipper với bán kính lỗ là 20
        child: Container(
          decoration: BoxDecoration(
            color: fourthColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "50% discount",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Apply",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 16, color: secondaryColor),
                            ),
                          )
                        ],
                      ),
                      Text(
                        // "${widget.voucher.discount} ",
                        "Save 50% for this booking",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: primaryColor,
                  height: 2,
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      "[30% OFF] discount for Podcast Day; Discounted price: 104.30; Get Now UI PRO Flutter 30% discount OFF now. [30% OFF] discount for Podcast Day; Discounted price: 104.30; Get Now UI PRO Flutter 30% discount OFF now.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DolDurmaClipper - CustomClipper để tạo hình dạng đặc biệt cho widget couponWidget
class DolDurmaClipper extends CustomClipper<Path> {
  final double holeRadius; // Bán kính của lỗ tròn giữa widget

  DolDurmaClipper({required this.holeRadius});

  @override
  Path getClip(Size size) {
    var bottom = size.height / 2; // Tính toán độ cao của phần dưới widget
    final path = Path()
      ..moveTo(0, 0) // Di chuyển tới điểm (0, 0)
      ..lineTo(
          0.0,
          size.height -
              bottom -
              holeRadius) // Vẽ đoạn thẳng đến điểm trước lỗ tròn
      ..arcToPoint(
        Offset(0, size.height - bottom),
        clockwise: true,
        radius: const Radius.circular(1),
      )
      ..lineTo(0.0, size.height) // Vẽ đoạn thẳng dọc theo cạnh dưới của widget
      ..lineTo(size.width,
          size.height) // Vẽ đoạn thẳng dọc theo cạnh phải của widget
      ..lineTo(
          size.width,
          size.height -
              bottom) // Vẽ đoạn thẳng dọc theo cạnh trên của phần dưới widget
      ..arcToPoint(
        Offset(size.width, size.height - bottom - holeRadius),
        clockwise: true,
        radius: const Radius.circular(1),
      );

    path.lineTo(size.width, 0.0); // Vẽ đoạn thẳng đến điểm cuối cùng

    path.close(); // Kết thúc đường vẽ và đóng hình
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) =>
      true; // Luôn tái tạo clipper khi cần thiết
}
