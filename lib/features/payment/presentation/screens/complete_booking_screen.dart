// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/webview.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';
import 'package:zest_trip/features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'package:zest_trip/features/payment/presentation/screens/voucher_screen.dart';
import 'package:zest_trip/features/payment/presentation/widgets/bottomsheet_participant.dart';

class CompleteBookingScreen extends StatefulWidget {
  final BookingEntity orderEntity;
  final int refundBefore;
  final int totalAdult;
  final int totalChildren;
  final List<dynamic> locations;
  const CompleteBookingScreen({
    Key? key,
    required this.orderEntity,
    required this.refundBefore,
    required this.totalAdult,
    required this.totalChildren,
    required this.locations,
  }) : super(key: key);

  @override
  State<CompleteBookingScreen> createState() => _CompleteBookingScreenState();
}

class _CompleteBookingScreenState extends State<CompleteBookingScreen> {
  String fullname = "";
  String phone = "";
  String email = "";
  String note = "";
  int totalDiscount = 0;
  int discountedAmount = 0;
  int? appliedVoucherId;
  int? paid;
  int? priceAdult;
  int? priceChildren;
  String? selectedLocation;

  @override
  void initState() {
    fullname = BlocProvider.of<AuthBloc>(context).state.user?.fullName ?? "";
    email = BlocProvider.of<AuthBloc>(context).state.user?.email ?? "";
    phone = BlocProvider.of<AuthBloc>(context).state.user?.phoneNumber ?? "";
    paid = BlocProvider.of<PaymentBloc>(context)
            .state
            .payment?["customerPayment"]["paid_price"] ??
        0;
    priceAdult = BlocProvider.of<PaymentBloc>(context)
            .state
            .payment?["customerPayment"]["adult_price"] ??
        0;
    priceChildren = BlocProvider.of<PaymentBloc>(context)
            .state
            .payment?["customerPayment"]["children_price"] ??
        0;
    discountedAmount = paid!;

    if (widget.locations.isNotEmpty) {
      final firstLocation = widget.locations[0];
      selectedLocation =
          '${firstLocation["deparute"] ?? ''} - ${firstLocation["time"] ?? ''}';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is BookTourSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyWebView(
                        title: "Complete payment",
                        urlWeb: state.url,
                      )));
        }
        if (state is BookTourFail) {
          Fluttertoast.showToast(
            msg:
                "${state.error?.response?.data["message"] ?? "Book tour failed"}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "Complete Booking",
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.1),
            child: Divider(
              color: Colors.black,
            ),
          ),
          actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.info_outline))
          ],
        ),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(spaceBody / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.orderEntity.tourName!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Date: ${DateFormat('dd-MM-yyyy').format(widget.orderEntity.selectedDate!)}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "Time: ${widget.orderEntity.timeSlot}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "Adult x${widget.orderEntity.adult}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "Children x${widget.orderEntity.children}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                            "${NumberFormatter.format(widget.orderEntity.totalPrice!)} ₫",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text(
                            "Free cancellation before ${widget.refundBefore} days",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: primaryColor)),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    color: colorLightGrey,
                  ),
                  // Start Participant details
                  _detailPayment(state),
                  Container(
                    height: 8,
                    color: colorLightGrey,
                  ),
                  // Start Participant details
                  Container(
                    padding: const EdgeInsets.all(spaceBody / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Titles(title: "Select departure location"),
                        const SizedBox(
                          height: 4,
                        ),
                        Column(
                          children:
                              (widget.locations.cast<Map<String, dynamic>>())
                                  .asMap()
                                  .entries
                                  .map((location) {
                            // final index = location.key;
                            final combinedValue =
                                '${location.value["deparute"] ?? ''} - ${location.value["time"] ?? ''}';
                            final isFirst = location.key == 0;
                            return RadioListTile<String>(
                              autofocus: isFirst,
                              contentPadding: const EdgeInsets.all(0),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location.value["deparute"] ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "At: ${location.value["time"]} ${NumberFormatter.checkAmPm(location.value["time"])}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              value: combinedValue,
                              groupValue: selectedLocation,
                              onChanged: (value) {
                                setState(() {
                                  selectedLocation = value;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    color: colorLightGrey,
                  ),
                  Container(
                    padding: const EdgeInsets.all(spaceBody / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Titles(title: "Participant details"),
                        InkWell(
                          onTap: () async {
                            Map<String, String>? result =
                                await showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: ParticipantBottomSheet(
                                    fullname: fullname,
                                    email: email,
                                    phone: phone,
                                  ),
                                );
                              },
                            );

                            _displayParticipantInfo(result);
                          },
                          child: Chip(
                            side: const BorderSide(
                              color: primaryColor,
                            ),
                            label: Text(
                              "Edit",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                            ),
                            avatar: const Icon(
                              Icons.edit,
                              color: primaryColor,
                              weight: 700,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colorHint,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(spaceBody / 2),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFormField("Full name"),
                                  const SizedBox(height: 8.0),
                                  _buildFormField("Phone number"),
                                  const SizedBox(height: 8.0),
                                  _buildFormField("Email"),
                                  const SizedBox(height: 8.0),
                                  const Text("Note special"),
                                ],
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8.0),
                                    Text(
                                      fullname.isEmpty ? "..." : fullname,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      phone.isEmpty ? "..." : phone,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      email.isEmpty ? "Please enter" : email,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      note.isEmpty
                                          ? "Any special request?"
                                          : note,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    color: colorLightGrey,
                  ),
                  // End Participant details

                  //Statr discount
                  Container(
                    padding: const EdgeInsets.all(spaceBody / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Titles(title: "Discounts"),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoucherScreen(
                                          tourId: widget.orderEntity.tourId!,
                                          paid: paid!,
                                        )));
                            _handleVoucherResult(result);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Use promo code"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                          "Select promo code or enter a new one")
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //End Discount
                  Container(
                    padding: const EdgeInsets.all(spaceBody / 2),
                    margin:
                        const EdgeInsets.symmetric(horizontal: spaceBody / 2),
                    decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        border: Border.all(color: Colors.yellow[700]!),
                        borderRadius: BorderRadius.circular(16)),
                    child: const Text(
                      'Please enter your info carefully. Once submitted it cannot be changed.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                  )
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Paid:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      " ${NumberFormatter.format(discountedAmount)} ₫",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              ElevatedButtonCustom(
                onPressed: () {
                  if (fullname == "" || phone == "" || email == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Please fill full the information contact!"),
                    ));
                  } else {
                    BookingEntity bookingEntity = BookingEntity(
                      bookerName: fullname,
                      bookerPhone: phone,
                      bookerEmail: email,
                      adult: widget.orderEntity.adult,
                      children: widget.orderEntity.children ?? 0,
                      selectedDate: widget.orderEntity.selectedDate,
                      tourId: widget.orderEntity.tourId,
                    );

                    context.read<PaymentBloc>().add(CreateBooking(
                          bookingEntity: bookingEntity,
                          voucherId: appliedVoucherId,
                          location: selectedLocation,
                        ));
                  }
                },
                text: "Go to payment",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _detailPayment(PaymentState state) {
    return Container(
      padding: const EdgeInsets.all(spaceBody / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Titles(title: "Details payment"),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("x${widget.totalAdult} Adult"),
              Text(
                state is CheckSuccess
                    ? "${NumberFormatter.format(priceAdult!)} ₫"
                    : "",
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("x${widget.totalChildren} Children"),
              Text(
                state is CheckSuccess
                    ? "${NumberFormatter.format(priceChildren!)} ₫"
                    : "",
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("DISCOUNT voucher"),
              Text("- ${NumberFormatter.format(totalDiscount)} đ"),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total amount:"),
              Text("${NumberFormatter.format(discountedAmount)} ₫"),
            ],
          ),
        ],
      ),
    );
  } // Hàm hiển thị thông tin người tham gia lên UI

  void _displayParticipantInfo(Map<String, String>? result) {
    if (result != null) {
      setState(() {
        fullname = result['fullName'] ?? "";
        phone = result['phoneNumber'] ?? "";
        email = result['email'] ?? "";
        note = result['note'] ?? "";
      });
    }
  }

  int calculateDiscountedPrice(
      int totalPrice, String discountType, int discount) {
    int voucherPrice;

    if (discountType == "PERCENT") {
      voucherPrice = totalPrice * discount ~/ 100;
      voucherPrice = voucherPrice > totalPrice ? totalPrice : voucherPrice;

      setState(() {
        totalDiscount = voucherPrice;
      });

      return totalPrice - voucherPrice < 0 ? 0 : totalPrice - voucherPrice;
    } else {
      discount = discount > totalPrice ? totalPrice : discount;

      setState(() {
        totalDiscount = discount;
      });
      return totalPrice - discount < 0 ? 0 : totalPrice - discount;
    }
  }

  void _handleVoucherResult(Map<String, dynamic>? result) {
    if (result != null) {
      final discountType = result['discountType'];
      final discount = result['discount'];
      final voucherId = result['voucherId'];
      final paid = result['paid'];

      final newDiscountedAmount = calculateDiscountedPrice(
        paid,
        discountType,
        int.parse(discount),
      );

      setState(() {
        discountedAmount = newDiscountedAmount;
        appliedVoucherId = voucherId;
      });
    }
  }
}

Widget _buildFormField(String labelText) {
  return Row(
    children: [
      Text(
        labelText,
      ),
      const Text(
        '*',
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
    ],
  );
}
