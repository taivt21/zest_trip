// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/policy_webview.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';
import 'package:zest_trip/features/payment/domain/entities/order_entity.dart';
import 'package:zest_trip/features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'package:zest_trip/features/payment/presentation/screens/voucher_screen.dart';
import 'package:zest_trip/features/payment/presentation/widgets/bottomsheet_participant.dart';

class CompleteBookingScreen extends StatefulWidget {
  final OrderEntity orderEntity;
  const CompleteBookingScreen({
    Key? key,
    required this.orderEntity,
  }) : super(key: key);

  @override
  State<CompleteBookingScreen> createState() => _CompleteBookingScreenState();
}

class _CompleteBookingScreenState extends State<CompleteBookingScreen> {
  String fullname = "";
  String phone = "";
  String email = "";
  String note = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is BookTourSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyWebView(
                        urlWeb: state.url,
                      )));
        }
      },
      child: Scaffold(
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
            actions: const <Widget>[
              IconButton(onPressed: null, icon: Icon(Icons.info_outline))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(spaceBody / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderEntity.tourName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Date: ${DateFormat('dd-MM-yyyy').format(widget.orderEntity.selectedDate)}",
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
                      Text("${widget.orderEntity.totalPrice}₫",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text("Free cancellation (24-hours notice)",
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
                Container(
                  padding: const EdgeInsets.all(spaceBody / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Titles(title: "Participant details"),
                      InkWell(
                        onTap: () async {
                          // Hiển thị bottom sheet và nhận giá trị trả về
                          Map<String, String>? result =
                              await showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            context: context,
                            builder: (context) {
                              return const ParticipantBottomSheet();
                            },
                          );

                          // Gọi hàm hiển thị thông tin người tham gia lên UI
                          _displayParticipantInfo(result);
                        },
                        child: Chip(
                          side: const BorderSide(
                            color: primaryColor,
                          ),
                          label: Text(
                            "Add",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                          avatar: const Icon(
                            Icons.add,
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full name"),
                                SizedBox(height: 8.0),
                                Text("Phone number"),
                                SizedBox(height: 8.0),
                                Text("Email"),
                                SizedBox(height: 8.0),
                                Text("Note special"),
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
                                    fullname.isEmpty
                                        ? "Please enter"
                                        : fullname,
                                    style: const TextStyle(color: colorHint),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    phone.isEmpty ? "Please enter" : phone,
                                    style: const TextStyle(color: colorHint),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    email.isEmpty ? "Please enter" : email,
                                    style: const TextStyle(color: colorHint),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text("Any special request?"),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VoucherScreen()));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Use promo code"),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Select promo code or enter a new one")
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
                  margin: const EdgeInsets.symmetric(horizontal: spaceBody / 2),
                  decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      border: Border.all(color: Colors.yellow[700]!),
                      borderRadius: BorderRadius.circular(16)),
                  child: const Text(
                    'Please enter your info carefully. Once submitted it cannot be changed.',
                    style: TextStyle(
                      color: Colors.black, // Màu chữ đen
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.orderEntity.totalPrice} ₫",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  ElevatedButtonCustom(
                    onPressed: () {
                      context.read<PaymentBloc>().add(CreateBooking(
                          name: fullname,
                          phone: phone,
                          email: email,
                          adult: widget.orderEntity.adult,
                          children: widget.orderEntity.children ?? 0,
                          selectDate: widget.orderEntity.selectedDate,
                          tourId: widget.orderEntity.tourId));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const PaymentScreen()));
                    },
                    text: "Go to payment",
                  ),
                ],
              ))),
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
}
