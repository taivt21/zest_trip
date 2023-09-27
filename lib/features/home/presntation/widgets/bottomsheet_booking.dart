import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/home/presntation/screens/complete_booking_screen.dart';

class BookingBottomSheet extends StatefulWidget {
  const BookingBottomSheet({super.key});

  @override
  BookingBottomSheetState createState() => BookingBottomSheetState();
}

class BookingBottomSheetState extends State<BookingBottomSheet> {
  final DateTime currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  DateTime _returnDate = DateTime.now();
  final int _tourDuration = 6;
  int _adult = 0;
  int _children = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Options',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "City tour + Cu chi Tunnels Tour ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Text(
                  "Detail",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(
                    "Free cancelation (24-hours notice)",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: fourthColor,
                ),
                Chip(
                  label: Text(
                    "Best choice",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: fourthColor,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date Picker
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorGrey,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Text(' Please select a tour date',
                          style: Theme.of(context).textTheme.bodyMedium!
                          // .copyWith(fontWeight: FontWeight.bold),
                          ),
                    ],
                  ),
                  const Divider(
                    indent: 5,
                    endIndent: 5,
                  ),
                  const Text(
                    "Check availability",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            '${_selectedDate.toLocal()}'.split(' ')[0],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          leading: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      const Text(
                        " - ",
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            '${_returnDate.toLocal()}'.split(' ')[0],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorGrey,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: colorGrey,
                          size: 16,
                        ),
                        Text(
                          ' Please select a ticket type',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const Divider(
                      indent: 5,
                      endIndent: 5,
                    ),
                    ListTile(
                      title: Text(
                        'Adult',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: const Text("100,000 ₫"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 16,
                              color: _adult > 0 ? Colors.black : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_adult > 0) {
                                  _adult--;
                                }
                              });
                            },
                          ),
                          Text(
                            _adult.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: () {
                              setState(() {
                                _adult++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Children',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: const Text("50,000 ₫"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 16,
                              color: _children > 0 ? Colors.black : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_children > 0) {
                                  _children--;
                                }
                              });
                            },
                          ),
                          Text(
                            _children.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: () {
                              setState(() {
                                _children++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            const Divider(),
            Text(
              "100,000 ₫",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            ElevatedButtonCustom(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompleteBookingScreen()));
              },
              text: tBookTour,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate.isBefore(currentDate) ? currentDate : _selectedDate,
      firstDate: currentDate,
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _returnDate = picked.add(Duration(days: _tourDuration));
      });
    }
  }
}
