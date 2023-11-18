// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/presentation/screens/refund_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/review_screen.dart';
import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';

class CardTourManage extends StatelessWidget {
  final InvoiceEntity invoice;

  const CardTourManage({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    homeSvg,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${invoice.tour?['Provider']['company_name']}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text(
                invoice.status!.replaceAll('_', ' '),
                style: const TextStyle(color: colorSuccess),
              )
            ],
          ),
          const Divider(
            color: colorPlaceHolder,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${invoice.tour?['name']} ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                        "${DateFormat('dd MMM yyyy').format(invoice.bookedDate!)} ${invoice.timeSlot} (Local time)",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: invoice.ticketOnBooking!.map((ticket) {
                        return Text(
                          "x${ticket.quantity} ${ticket.ticketTypeId == 1 ? 'Adult' : 'Children'}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${invoice.tour!["tour_images"][0]}"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: colorPlaceHolder,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Price: "),
                      Text(
                        "${NumberFormatter.format(num.parse(invoice.originalPrice!))} ₫",
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .bodySmall
                        //     ?.copyWith(
                        //         decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  Text(
                      "Paid: ${NumberFormatter.format(num.parse(invoice.paidPrice!))} ₫"),
                ],
              ),
              Row(
                children: [
                  invoice.status?.toLowerCase() == "pending"
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Continue payment",
                            style: TextStyle(color: whiteColor),
                          ),
                        )
                      : TextButton(
                          onPressed: canRefund(invoice)
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RefundScreen(
                                        refundAmount: invoice.refundAmount!,
                                        bookingId: invoice.id!,
                                        image: invoice.tour!["tour_images"][0],
                                        location:
                                            invoice.tour!["address_province"],
                                        paid: invoice.paidPrice!,
                                        tourName: invoice.tour!["name"],
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: Text(
                            "Refund",
                            style: TextStyle(
                              color: canRefund(invoice) ? null : Colors.grey,
                              decoration: canRefund(invoice)
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  invoice.status?.toLowerCase() == "pending"
                      ? const SizedBox.shrink()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                canReview(invoice) ? primaryColor : Colors.grey,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: canReview(invoice)
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewScreen(
                                        tourId: invoice.tourId!,
                                        image: invoice.tour!["tour_images"][0],
                                        location:
                                            invoice.tour!["address_province"],
                                        paid: invoice.paidPrice!,
                                        tourName: invoice.tour!["name"],
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text(
                            "Review",
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

bool canRefund(InvoiceEntity invoice) {
  DateTime bookDate = invoice.bookedDate ?? DateTime.now();
  DateTime refundDate =
      bookDate.subtract(Duration(days: invoice.tour?["refund_before"] ?? 0));
  return DateTime.now().isBefore(refundDate) &&
      invoice.status?.toLowerCase() == "accepted";
}

bool canReview(InvoiceEntity invoice) {
  DateTime bookDate = invoice.bookedDate ?? DateTime.now();
  return DateTime.now().isAfter(bookDate) &&
      invoice.status?.toLowerCase() == "accepted";
}
