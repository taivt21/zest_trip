// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/resources/confirm_dialog.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/presentation/screens/home_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour.dart';
import 'package:zest_trip/features/payment/presentation/bloc/booking/booking_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/refund/refund_bloc.dart';

class RefundScreen extends StatefulWidget {
  final String bookingId;
  final String image;
  final String tourName;
  final String location;
  final String paid;
  final String refundAmount;
  const RefundScreen({
    Key? key,
    required this.bookingId,
    required this.image,
    required this.tourName,
    required this.location,
    required this.paid,
    required this.refundAmount,
  }) : super(key: key);

  @override
  RefundScreenState createState() => RefundScreenState();
}

class RefundScreenState extends State<RefundScreen> {
  TextEditingController commentController = TextEditingController();
  bool showError = false;

  Future<void> _showConfirmationDialog() async {
    bool? confirmed = await DialogUtils.showConfirmDialog(
      context,
      title: 'Confirm request refund',
      content: 'Are you sure you want to refund?',
      noText: 'Cancel',
      yesText: 'Confirm',
    );

    if (confirmed == true) {
      submitRefund();
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? confirmExit = await DialogUtils.showConfirmDialog(
          context,
          title: 'Confirm exit',
          content: 'Do you want to exit?',
          noText: 'No',
          yesText: 'Yes',
        );
        return confirmExit ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text('Request refund'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  showError = true;
                });
                if (validateReview()) {
                  _showConfirmationDialog();
                }
              },
              child: const Text(
                "Send",
                style: TextStyle(
                    decoration: TextDecoration.underline, fontSize: 15),
              ),
            )
          ],
        ),
        body: BlocListener<RefundBloc, RefundState>(
          listener: (context, state) {
            if (state is RequestRefundFail) {
              Fluttertoast.showToast(
                msg: "${{state.error?.response?.data['message']}}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
            if (state is RequestRefundSuccess) {
              // BlocProvider.of<MyReviewBloc>(context).add(GetMyReview());
              BlocProvider.of<BookingBloc>(context).add(const GetBookings());
              Fluttertoast.showToast(
                msg: "Request refund success!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );

              Navigator.pushAndRemoveUntil(
                context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen(initialPageIndex: 2)),
                  (route) => false);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              // decoration: const BoxDecoration(color: colorBackground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TourCard(
                    location: widget.location,
                    tourName: widget.tourName,
                    imageUrl: widget.image,
                    price: NumberFormatter.format(num.parse(widget.paid)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Refund amount (70%):",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 16),
                      ),
                      Text(
                          "${NumberFormatter.format(num.parse(widget.paid) * 70 / 100)} ₫",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your reason:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  buildCommentTextField(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButtonCustom(
              onPressed: () {
                setState(() {
                  showError = true;
                });
                if (validateReview()) {
                  _showConfirmationDialog();
                }
              },
              text: "Request refund",
            ),
          ),
        ),
      ),
    );
  }

  bool validateReview() {
    return commentController.text.length >= 10;
  }

  Widget buildCommentTextField() {
    return TextField(
      controller: commentController,
      maxLines: 6,
      maxLength: 1000,
      decoration: InputDecoration(
        hintText: 'Please share your reason on this service!',
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(),
        errorText: showError && commentController.text.length < 10
            ? 'Please enter at least 10 characters.'
            : null,
      ),
      onEditingComplete: () {},
    );
  }

  void submitRefund() {
    context.read<RefundBloc>().add(RequestRefundEvent(
        reason: commentController.text, bookingId: widget.bookingId));
  }
}
