import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/order_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_availability_entity.dart';
import 'package:zest_trip/features/payment/presentation/screens/complete_booking_screen.dart';

class BookingBottomSheet extends StatefulWidget {
  final TourEntity tour;
  const BookingBottomSheet({super.key, required this.tour});

  @override
  BookingBottomSheetState createState() => BookingBottomSheetState();
}

class BookingBottomSheetState extends State<BookingBottomSheet> {
  late DateTime selectedDate;
  late DateTime returnDate;

  int _adult = 1;
  int _children = 0;
  int _totalPrice = 0;
  String timeSlot = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    DateTime currentDate = DateTime.now();

    selectedDate = currentDate;

    returnDate = selectedDate.add(Duration(days: widget.tour.duration!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Booking Options',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const Divider(
            color: colorPlaceHolder,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${widget.tour.name}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20),
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            children: [
              Chip(
                label: Text(
                  "Free cancellation (24-hours notice)",
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
                color: colorPlaceHolder,
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
                      color: colorBlack,
                      size: 16,
                    ),
                    Text(' Please select a tour date',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const Divider(
                  color: colorPlaceHolder,
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
                          DateFormat('dd-MM-yyyy').format(selectedDate),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        onTap: () {
                          _selectDate();
                        },
                      ),
                    ),
                    const Text(
                      " - ",
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          DateFormat('dd-MM-yyyy').format(returnDate),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                // Hiển thị timeslot

                Chip(
                  label: Text(
                    '${DateFormat('EEEE').format(selectedDate)}, ${DateFormat('dd MMMM').format(selectedDate)} ,Time of departure: ${getSelectedTimeSlot(selectedDate)}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: fourthColor,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorPlaceHolder,
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
                      Icon(
                        Icons.info_outline,
                        color: colorBoldGrey,
                        size: 16,
                      ),
                      Text(
                        ' Please select a ticket type',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Divider(
                    color: colorPlaceHolder,
                    indent: 5,
                    endIndent: 5,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.tour.pricingTicket!.length,
                    itemBuilder: (context, index) {
                      PricingTicketEntity ticketPricing =
                          widget.tour.pricingTicket![index];
                      return ListTile(
                        title: Text(
                          ticketPricing.ticket?.name!
                                  .toLowerCase()
                                  .replaceAllMapped(
                                      RegExp(r'\b\w'),
                                      (match) =>
                                          match.group(0)!.toUpperCase()) ??
                              "ticket name",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        // subtitle: Text("${ticketPricing.ticket?.name} ₫"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                size: 16,
                                color: 1 > 0 ? colorBlack : colorPlaceHolder,
                              ),
                              onPressed: () {
                                setState(() {
                                  _decreaseAmount(ticketPricing);
                                });
                              },
                            ),
                            Text(
                              ticketPricing.ticketTypeId == 1
                                  ? _adult.toString()
                                  : _children.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {
                                setState(() {
                                  _increaseAmount(ticketPricing);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          const Divider(
            color: colorPlaceHolder,
          ),
          Text(
            "${calculateTotalPrice().toString()}₫ ",
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
                      builder: (context) => CompleteBookingScreen(
                            orderEntity: OrderEntity(
                                tourId: widget.tour.id!,
                                tourName: widget.tour.name!,
                                adult: _adult,
                                children: _children,
                                totalPrice: _totalPrice,
                                selectedDate: selectedDate,
                                returnDate: returnDate,
                                timeSlot: timeSlot),
                          )));
            },
            text: tBookTour,
          ),
        ],
      ),
    );
  }

  void _decreaseAmount(PricingTicketEntity ticketPricing) {
    if (ticketPricing.ticketTypeId == 1) {
      if (_adult > 0) {
        _adult--;
      }
    } else {
      if (_children > 0) {
        _children--;
      }
    }
  }

  void _increaseAmount(PricingTicketEntity ticketPricing) {
    if (ticketPricing.ticketTypeId == 1) {
      _adult++;
    } else {
      _children++;
    }
  }

  int calculateTotalPrice() {
    int totalAdultPrice = 0;
    int totalChildrenPrice = 0;

    for (var ticketPricing in widget.tour.pricingTicket!) {
      int quantity;

      if (ticketPricing.ticketTypeId == 1) {
        quantity = _adult;
      } else {
        quantity = _children;
      }

      if (quantity > 0) {
        int totalPrice = 0;

        // Số lượng vé còn lại cần mua
        int remainingQuantity = quantity;

        for (var priceRange in ticketPricing.priceRange!) {
          int fromAmount = priceRange.fromAmount ?? 0;
          int toAmount = priceRange.toAmount ?? 0;
          int price = priceRange.price ?? 0;

          // Số lượng vé trong khoảng giá hiện tại
          int rangeQuantity =
              (toAmount - fromAmount).clamp(0, remainingQuantity);

          // Cộng thêm giá của khoảng giá hiện tại vào tổng giá vé
          totalPrice += price * rangeQuantity;

          // Giảm số lượng vé còn lại dựa trên khoảng giá hiện tại
          remainingQuantity -= rangeQuantity;

          // Nếu đã đủ số lượng vé cần mua, thoát khỏi vòng lặp
          if (remainingQuantity == 0) {
            break;
          }
        }

        // Nếu vẫn còn vé cần mua và còn thêm khoảng giá
        if (remainingQuantity > 0 && ticketPricing.priceRange!.isNotEmpty) {
          // Sử dụng khoảng giá cuối cùng để tính giá còn lại
          var lastPriceRange = ticketPricing.priceRange!.last;
          int lastRangePrice = lastPriceRange.price ?? 0;

          // Cộng giá của khoảng giá cuối cùng vào tổng giá vé
          totalPrice += lastRangePrice * remainingQuantity;
        }

        // Thêm giá vé vào tổng giá tương ứng
        if (ticketPricing.ticketTypeId == 1) {
          totalAdultPrice += totalPrice;
        } else {
          totalChildrenPrice += totalPrice;
        }
      }
    }

    // Gọi setState để cập nhật giá trị total
    setState(() {
      _totalPrice = totalAdultPrice + totalChildrenPrice;
    });

    return _totalPrice;
  }

  // Đặt giờ, phút, giây về 0 để so sánh theo ngày
  DateTime truncateTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  Future<void> _selectDate() async {
    DateTime currentDate = DateTime.now();
    DateTime? picked;
    List<TourAvailabilityEntity>? tourAvailability =
        widget.tour.tourAvailability;
    List<DateTime> validDates = [];

    if (tourAvailability != null && tourAvailability.isNotEmpty) {
      for (var availability in tourAvailability) {
        DateTime startDate = availability.validityDateRangeFrom!;
        DateTime endDate = availability.validityDateRangeTo!;

        if (currentDate.isAfter(startDate) &&
            currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
          // Include all valid dates in the range
          for (var date = startDate;
              date.isBefore(endDate.add(const Duration(days: 1)));
              date = date.add(const Duration(days: 1))) {
            // Check if the date is a valid weekday
            if (availability.weekdays!
                .any((weekday) => date.weekday == weekday.day)) {
              validDates.add(date);
            }
          }
        }
      }

      print(
        "validDates.first ${validDates.first}, validDates.last: ${validDates.last}, valid date: $validDates",
      );

// Chuyển đổi ngày khởi tạo sang biểu diễn của Flutter
      DateTime initialDate = _findInitialDate(validDates, currentDate);

      picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: validDates.first,
        lastDate: validDates.last,
        selectableDayPredicate: (DateTime day) {
          // Đảm bảo rằng selectableDayPredicate được thiết lập đúng
          print("selectableDayPredicate: $day");

          return validDates
                  .any((date) => truncateTime(date) == truncateTime(day)) &&
              day.isAfter(currentDate.subtract(const Duration(days: 1)));
        },
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked!;
          returnDate = picked.add(Duration(days: widget.tour.duration!));
          timeSlot = getSelectedTimeSlot(picked);
        });
      }
    }
  }

  DateTime _findInitialDate(List<DateTime> validDates, DateTime currentDate) {
    for (var date in validDates) {
      if (date.year == currentDate.year &&
          date.month == currentDate.month &&
          date.day == currentDate.day) {
        return date;
      }
    }
    return validDates.isNotEmpty ? validDates.first : currentDate;
  }

  String getSelectedTimeSlot(DateTime selectedDate) {
    List<TourAvailabilityEntity> tourAvailability =
        widget.tour.tourAvailability!;

    for (var availability in tourAvailability) {
      // Kiểm tra ngày special
      if (availability.specialDates!.isNotEmpty) {}
      for (var specialDate in availability.specialDates!) {
        DateTime specialDateTime = specialDate.date!;

        if (selectedDate.isAtSameMomentAs(specialDateTime)) {
          return specialDate.timeSlot ?? '';
        }
      }
      // Kiểm tra ngày trong weekdays
      for (var weekday in availability.weekdays!) {
        if (weekday.day == selectedDate.weekday) {
          return weekday.timeSlot!;
        }
      }
    }

    return '';
  }

  int convertApiWeekdayToFlutterWeekday(int apiWeekday) {
    switch (apiWeekday) {
      case 1:
        return DateTime.sunday;
      case 2:
        return DateTime.monday;
      case 3:
        return DateTime.tuesday;
      case 4:
        return DateTime.wednesday;
      case 5:
        return DateTime.thursday;
      case 6:
        return DateTime.friday;
      case 7:
        return DateTime.saturday;
      default:
        throw Exception("Giá trị ngày không hợp lệ từ API");
    }
  }
}
