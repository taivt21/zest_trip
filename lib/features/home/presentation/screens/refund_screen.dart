// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/presentation/screens/manage_review_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour.dart';
import 'package:zest_trip/features/payment/presentation/bloc/my_review/my_review_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request refund'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocListener<RefundBloc, RefundState>(
        listener: (context, state) {
          if (state is RequestRefundFail) {
            Fluttertoast.showToast(
                msg: "${{state.error?.response?.data['message']}}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is RequestRefundSuccess) {
            Fluttertoast.showToast(
                msg: "Request refund success!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
            context.read<MyReviewBloc>().add(GetMyReview());

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageReviewScreen(),
                ),
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
                    const Text("Refund amount:"),
                    Text("${widget.refundAmount} ₫")
                  ],
                ),
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
                submitReview();
              }
            },
            text: "Request refund",
          ),
        ),
      ),
    );
  }

  bool validateReview() {
    return commentController.text.length >= 20;
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
        errorText: showError && commentController.text.length < 20
            ? 'Please enter at least 20 characters.'
            : null,
      ),
      onEditingComplete: () {},
    );
  }

  void submitReview() {
    debugPrint('Comment: ${commentController.text}');
    context.read<RefundBloc>().add(RequestRefundEvent(
        reason: commentController.text, bookingId: widget.bookingId));
  }
}
