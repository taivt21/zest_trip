// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/presentation/screens/photo_zoom_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/provider_profile_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/refund_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/review_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    invoice.tour!.providerId != null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProviderProfileScreen(
                                      providerId: invoice.tour!.providerId!,
                                    )))
                        : null;
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        homeSvg,
                        height: 20,
                        width: 20,
                        // ignore: deprecated_member_use
                        color: secondaryColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${invoice.tour?.provider?.companyName} ",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: '${invoice.id}'));
                    Fluttertoast.showToast(
                      msg: "Invoice id copied to clipboard!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          // invoice.status!.replaceAll('_', ' '),
                          // style: const TextStyle(
                          //   color: colorSuccess,
                          // ),
                          "#${invoice.id}",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.copy,
                        size: 16,
                      ),
                    ],
                  ),
                ),
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
                child: GestureDetector(
                  onTap: () {
                    showBookingDetailsDialog(context, invoice);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${invoice.tour?.name} ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                      invoice.note == ""
                          ? const SizedBox()
                          : Text(
                              "Note: ${invoice.note}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    invoice.tour!.id != null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TourDetailScreen(
                                    tourId: invoice.tour!.id!)))
                        : null;
                  },
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
                        // style: double.parse(invoice.originalPrice!) >
                        //         double.parse(invoice.paidPrice!)
                        //     ? Theme.of(context).textTheme.bodySmall?.copyWith(
                        //         decoration: TextDecoration.lineThrough)
                        //     : null,
                      ),
                    ],
                  ),
                  Text(
                      "Paid: ${NumberFormatter.format(num.parse(invoice.paidPrice!))} ₫"),
                ],
              ),
              invoice.status == "REFUNDED" ||
                      invoice.status == "PROVIDER_REFUNDED"
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
                                    commissionRate: invoice.commissionRate!,
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

void showBookingDetailsDialog(BuildContext context, InvoiceEntity invoice) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Booking Details'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetailRow("Name: ", invoice.bookerName!),
                buildDetailRow("Email: ", invoice.bookerEmail!),
                buildDetailRow("Phone: ", invoice.bookerPhone!),
                buildDetailRow("Book date: ",
                    DateFormat('dd MMMM yyyy').format(invoice.bookedDate!)),
                buildDetailRow("Paid Price: ",
                    '${NumberFormatter.format(num.parse(invoice.paidPrice!))} ₫'),
                buildDetailRow("Original Price: ",
                    '${NumberFormatter.format(num.parse(invoice.originalPrice!))} ₫'),
                invoice.departureLocation != ""
                    ? buildDetailRow(
                        "Departure location: ", '${invoice.departureLocation}')
                    : const SizedBox.shrink(),
                invoice.refundReason != null
                    ? buildDetailRow("Reason refund:", invoice.refundReason!)
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

Widget buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 3,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
          flex: 7,
          child: Text(value),
        ),
      ],
    ),
  );
}

bool canRefund(InvoiceEntity invoice) {
  DateTime bookDate = invoice.bookedDate ?? DateTime.now();
  DateTime refundDate =
      bookDate.subtract(Duration(days: invoice.tour?.refundBefore ?? 0));
  return DateTime.now().isBefore(refundDate) &&
      invoice.status?.toLowerCase() == "accepted";
}

bool canReview(InvoiceEntity invoice) {
  DateTime now = DateTime.now();
  DateTime bookDate = invoice.bookedDate ?? now;
  // Loại bỏ thành phần giờ, phút, giây để chỉ so sánh ngày tháng năm
  now = DateTime(now.year, now.month, now.day);
  bookDate = DateTime(bookDate.year, bookDate.month, bookDate.day);
  // print("now: $now, bookDate: $bookDate");

  return (now.isAfter(bookDate) || now.isAtSameMomentAs(bookDate)) &&
      invoice.status?.toLowerCase() == "accepted" &&
      invoice.isReviewed! == false;
}
