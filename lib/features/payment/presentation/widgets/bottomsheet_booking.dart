import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_range_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_availability_entity.dart';
import 'package:zest_trip/features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'package:zest_trip/features/payment/presentation/screens/complete_booking_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  late int _totalAdults;
  late int _totalChildren;

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
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is CheckSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompleteBookingScreen(
                        totalAdult: _totalAdults,
                        totalChildren: _totalChildren,
                        refundBefore: widget.tour.refundBefore!,
                        orderEntity: BookingEntity(
                          tourId: widget.tour.id!,
                          tourName: widget.tour.name!,
                          adult: _adult,
                          children: _children,
                          totalPrice: _totalPrice,
                          selectedDate: selectedDate,
                          returnDate: returnDate,
                          timeSlot: timeSlot,
                        ),
                      )));
        } else if (state is CheckFail) {
          Fluttertoast.showToast(
              msg: "${state.error?.response?.data['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
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
                          "Free cancellation before ${widget.tour.refundBefore} days",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: fourthColor,
                      ),
                      Chip(
                        label: Text(
                          "Best choice",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
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
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: colorBoldGrey,
                                      size: 16,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        ' Please select a ticket',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    showPricingInfoDialog(
                                        widget.tour.pricingTicket!);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Chip(
                                          side: BorderSide.none,
                                          labelPadding: const EdgeInsets.all(0),
                                          label: Text(
                                            "Buy for discount",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: secondaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                          ),
                                          backgroundColor: fourthColor,
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: secondaryColor,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                              int totalPrice = (ticketPricing.ticketTypeId == 1)
                                  ? _totalAdults
                                  : _totalChildren;
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      "${ticketPricing.ticket?.name?.toLowerCase().replaceAllMapped(RegExp(r'\b\w'), (match) => match.group(0)!.toUpperCase())}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      " (${ticketPricing.fromAge} - ${ticketPricing.toAge})",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                subtitle: (totalPrice > 0)
                                    ? Text(
                                        "${NumberFormatter.format(totalPrice)}₫",
                                      )
                                    : Text(
                                        "From ${NumberFormatter.format(num.parse(ticketPricing.fromPrice!))}₫",
                                      ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        size: 16,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
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
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Divider(
                      color: colorPlaceHolder,
                    ),
                    Row(
                      children: [
                        const Text("Total: "),
                        Text(
                          "${NumberFormatter.format(calculateTotalPrice())}₫ ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    ElevatedButtonCustom(
                      onPressed: () {
                        debugPrint(
                            "tourId: ${widget.tour.id}, adult: $_adult, child: $_children, date: $selectedDate");
                        context.read<PaymentBloc>().add(CheckAvailable(
                            widget.tour.id!, _adult, _children, selectedDate));
                      },
                      text: tBookTour,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  int calculatePriceForTicket(
      int quantity, List<PricingTicketRangeEntity> priceRanges) {
    int totalPrice = 0;
    int remainingQuantity = quantity;

    for (var priceRange in priceRanges) {
      int fromAmount = priceRange.fromAmount ?? 0;
      int toAmount = priceRange.toAmount ?? 0;
      int price = priceRange.price ?? 0;

      int rangeQuantity = (toAmount - fromAmount).clamp(0, remainingQuantity);
      totalPrice += price * rangeQuantity;

      remainingQuantity -= rangeQuantity;

      if (remainingQuantity == 0) {
        break;
      }
    }

    if (remainingQuantity > 0 && priceRanges.isNotEmpty) {
      var lastPriceRange = priceRanges.last;
      int lastRangePrice = lastPriceRange.price ?? 0;
      totalPrice += lastRangePrice * remainingQuantity;
    }

    return totalPrice;
  }

  int calculateTotalPrice() {
    int totalAdultPrice = 0;
    int totalChildrenPrice = 0;

    for (var ticketPricing in widget.tour.pricingTicket!) {
      int quantity = (ticketPricing.ticketTypeId == 1) ? _adult : _children;

      if (quantity > 0) {
        int totalPrice =
            calculatePriceForTicket(quantity, ticketPricing.priceRange!);

        if (ticketPricing.ticketTypeId == 1) {
          totalAdultPrice += totalPrice;
        } else {
          totalChildrenPrice += totalPrice;
        }
      }
    }

    setState(() {
      _totalAdults = totalAdultPrice;
      _totalChildren = totalChildrenPrice;
      _totalPrice = _totalAdults + _totalChildren;
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
        for (var date = startDate;
            date.isBefore(endDate.add(const Duration(days: 1)));
            date = date.add(const Duration(days: 1))) {
          // Check if the date is a valid weekday and is after or at the same moment as the current date
          if (availability.weekdays!.any((weekday) =>
                  date.weekday ==
                  convertApiWeekdayToFlutterWeekday(weekday.day!)) &&
              (date.isAfter(currentDate) ||
                  date.isAtSameMomentAs(currentDate))) {
            validDates.add(date);
          }
        }
      }

// Chuyển đổi ngày khởi tạo sang biểu diễn của Flutter
      DateTime initialDate = _findInitialDate(validDates, currentDate);

      if (validDates.isNotEmpty) {
        picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: validDates.first,
          lastDate: validDates.last,
          selectableDayPredicate: (DateTime day) {
            debugPrint("selectableDayPredicate: $day");

            return validDates
                    .any((date) => truncateTime(date) == truncateTime(day)) &&
                day.isAfter(currentDate.subtract(const Duration(days: 1)));
          },
        );
      } else {
        Fluttertoast.showToast(
            msg: "Oops, looks like there's no valid date",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked!;
          returnDate = picked.add(Duration(days: widget.tour.duration! - 1));
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
        if (convertApiWeekdayToFlutterWeekday(weekday.day!) ==
            selectedDate.weekday) {
          return weekday.timeSlot!;
        }
      }
    }

    return '';
  }

  void showPricingInfoDialog(List<PricingTicketEntity> pricingTickets) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Buy more for discount"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: pricingTickets.length,
              itemBuilder: (context, index) {
                PricingTicketEntity ticketPricing = pricingTickets[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Ticket: ${ticketPricing.ticket?.name}"),
                      subtitle: Text(
                        "Age: ${ticketPricing.fromAge} - ${ticketPricing.toAge}",
                      ),
                    ),
                    // Display pricing information for the ticket
                    for (var range in ticketPricing.priceRange!)
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                              ' Buy ${range.fromAmount} -  ${range.toAmount} : ${NumberFormat("#,###").format(range.price)} ₫'),
                        ],
                      ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
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
