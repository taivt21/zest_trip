import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presntation/screens/payment_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/voucher_screen.dart';
import 'package:zest_trip/features/home/presntation/widgets/bottomsheet_participant.dart';

class CompleteBookingScreen extends StatelessWidget {
  const CompleteBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Complete Booking",
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          centerTitle: true,
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mekong River Day Tour from Ho Chi Minh",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "23 Sep 2023",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "Adult x1",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text("₫ 500,000",
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
                color: colorGrey,
              ),
              // Start Participant details
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 4,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Text(
                          "Participant details",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          context: context,
                          builder: (context) {
                            return const Padding(
                                padding: EdgeInsets.all(16),
                                child: ParticipantBottomSheet());
                          },
                        );
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
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First name"),
                              SizedBox(height: 8.0),
                              Text("Last name"),
                              SizedBox(height: 8.0),
                              Text("Phone number"),
                              SizedBox(height: 8.0),
                              Text("Email"),
                              SizedBox(height: 8.0),
                              Text("Note special"),
                            ],
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Please enter",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Please enter",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Please enter",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Please enter",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 8.0),
                                Text("Any special request?"),
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
                color: colorGrey,
              ),
              // End Participant details

              //Statr discount
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 4,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Text(
                          "Discounts",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
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
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
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
                  "100,000 ₫",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButtonCustom(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentScreen()));
                  },
                  text: "Go to payment",
                ),
              ],
            )));
  }
}
