// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/presentation/screens/photo_zoom_screen.dart';
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
                    "${invoice.tour?.provider?.companyName} ",
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
                      "${invoice.tour?.name} ",
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
                      image: CachedNetworkImageProvider(
                          "${invoice.tour?.tourImages?.first}"),
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
              invoice.status == "REFUNDED"
                  ? TextButton(
                      onPressed: () {
                        List<String> url = [];
                        url.add(invoice.refundImage ??
                            "https://cdn.pixabay.com/photo/2017/08/20/10/47/grey-2661270_1280.png");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoZoomScreen(
                              imageUrls: url,
                              initialIndex: 1,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Refund image",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(decoration: TextDecoration.underline),
                      ))
                  : Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (canRefund(invoice)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RefundScreen(
                                    refundAmount:
                                        invoice.refundAmount ?? "refundAmount",
                                    bookingId: invoice.id!,
                                    image: invoice.tour!.tourImages!.first,
                                    location: invoice.tour!.addressProvince!,
                                    paid: invoice.paidPrice!,
                                    tourName: invoice.tour!.name ?? "tour name",
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Need to refund before ${invoice.tour?.refundBefore} days"),
                                ),
                              );
                            }
                          },
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
                        ElevatedButton(
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
                                        image: invoice.tour!.tourImages!.first,
                                        location:
                                            invoice.tour!.addressProvince ??
                                                "addressProvince",
                                        paid: invoice.paidPrice!,
                                        tourName:
                                            invoice.tour!.name ?? "tourName",
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
      bookDate.subtract(Duration(days: invoice.tour?.refundBefore ?? 0));
  return DateTime.now().isBefore(refundDate) &&
      invoice.status?.toLowerCase() == "accepted";
}

bool canReview(InvoiceEntity invoice) {
  DateTime bookDate = invoice.bookedDate ?? DateTime.now();
  return DateTime.now().isAfter(bookDate) &&
      invoice.status?.toLowerCase() == "accepted";
}
