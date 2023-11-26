import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_voucher_entity.dart';

class CouponWidget extends StatefulWidget {
  final TourVoucherEntity voucher;
  final int paid;
  const CouponWidget({
    Key? key,
    required this.voucher,
    required this.paid,
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
          holeRadius: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: fourthColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
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
                          widget.voucher.discountType == "PERCENT"
                              ? "Discount ${widget.voucher.discount}%"
                              : "Discount ${NumberFormatter.format(num.parse(widget.voucher.discount!))}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 20),
                        ),
                        TextButton(
                          onPressed: widget.voucher.quantityUsed! >=
                                      widget.voucher.quantity! ||
                                  DateTime.now()
                                      .isAfter(widget.voucher.expiredDate!) ||
                                  widget.paid <
                                      widget.voucher
                                          .applyConditions?["minimum_price"]
                              ? null
                              : () {
                                  Navigator.pop(
                                    context,
                                    {
                                      'discountType':
                                          widget.voucher.discountType,
                                      'discount': widget.voucher.discount,
                                      'voucherId': widget.voucher.id
                                    },
                                  );
                                },
                          child: Text(
                            "Apply",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  color: _getApplyButtonColor(),
                                ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Minimum price: ${widget.voucher.applyConditions?["minimum_price"] ?? 0}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _getMinimumPriceTextStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: primaryColor,
                  height: 2,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.voucher.name}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Used ${_calculatePercentageUsed()}%, Date expired: ${_formatDate(widget.voucher.expiredDate)}",
                          style: _getExpirationTextStyle(),
                        ),
                        _buildVoucherStatus(),
                      ],
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

  Widget _buildVoucherStatus() {
    if (widget.voucher.quantityUsed! >= widget.voucher.quantity!) {
      return Text(
        "Voucher sold out",
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.grey),
      );
    } else if (DateTime.now().isAfter(widget.voucher.expiredDate!)) {
      return Text(
        "Out of date",
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.grey),
      );
    } else if (widget.paid < widget.voucher.applyConditions?["minimum_price"]) {
      return Text(
        "The minimum booking value is not enough",
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.grey),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  TextStyle _getExpirationTextStyle() {
    if (widget.voucher.quantityUsed! >= widget.voucher.quantity! ||
        DateTime.now().isAfter(widget.voucher.expiredDate!) ||
        widget.paid < widget.voucher.applyConditions?["minimum_price"]) {
      return Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey) ??
          const TextStyle();
    } else {
      return Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: colorWarning) ??
          const TextStyle();
    }
  }

  TextStyle _getMinimumPriceTextStyle() {
    if (widget.paid < widget.voucher.applyConditions?["minimum_price"]) {
      return Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey) ??
          const TextStyle();
    } else {
      return Theme.of(context).textTheme.titleSmall ?? const TextStyle();
    }
  }

  Color _getApplyButtonColor() {
    if (widget.voucher.quantityUsed! >= widget.voucher.quantity! ||
        DateTime.now().isAfter(widget.voucher.expiredDate!) ||
        widget.paid < widget.voucher.applyConditions?["minimum_price"]) {
      return Colors.grey;
    } else {
      return colorWarning;
    }
  }

  String _calculatePercentageUsed() {
    final num quantityUsed = widget.voucher.quantityUsed ?? 0;
    final num quantity = widget.voucher.quantity ?? 1;

    final num percentage = (quantityUsed / quantity) * 100;

    return NumberFormatter.format(num.parse(percentage.toString()));
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(date);
    }
    return '';
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  final double holeRadius;

  DolDurmaClipper({required this.holeRadius});

  @override
  Path getClip(Size size) {
    var bottom = size.height / 2;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0.0, size.height - bottom - holeRadius)
      ..arcToPoint(
        Offset(0, size.height - bottom),
        clockwise: true,
        radius: const Radius.circular(1),
      )
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - bottom)
      ..arcToPoint(
        Offset(size.width, size.height - bottom - holeRadius),
        clockwise: true,
        radius: const Radius.circular(1),
      );

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
