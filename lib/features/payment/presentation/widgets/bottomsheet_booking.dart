import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/payment/data/models/pricing_ticket_model.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_entity.dart';
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
  late PricingTicketEntity adultTicket;
  PricingTicketEntity? childrenTicket;
  int _adult = 1;
  int _children = 0;
  int _totalPriceAdult = 0;
  int _totalPriceChildren = 0;
  String timeSlot = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    returnDate = selectedDate.add(Duration(days: widget.tour.durationDay!));
    _initializeSelectedDate();
    adultTicket = filterTicket(widget.tour.pricingTicket!, selectedDate, 1);
    childrenTicket = filterTicket(widget.tour.pricingTicket!, selectedDate, 2);
    _totalPriceAdult = calculateTotalPrice(adultTicket, _adult) * _adult;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is CheckSuccess) {
          if (_totalPriceAdult + _totalPriceChildren !=
              state.payment!["customerPayment"]["paid_price"]) {
            Fluttertoast.showToast(
              msg: "Price ticket has changed by provider",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
            );
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompleteBookingScreen(
                        totalAdult: state.payment!["customerPayment"]
                            ["adult_price"],
                        totalChildren: state.payment!["customerPayment"]
                            ["children_price"],
                        refundBefore: widget.tour.refundBefore!,
                        locations: widget.tour.departureLocation?["location"]!,
                        orderEntity: BookingEntity(
                          tourId: widget.tour.id!,
                          tourName: widget.tour.name!,
                          adult: _adult,
                          children: _children,
                          totalPrice: state.payment!["customerPayment"]
                              ["paid_price"],
                          selectedDate: selectedDate,
                          returnDate: returnDate,
                          timeSlot: timeSlot,
                        ),
                      )));
        } else if (state is CheckFail) {
          Fluttertoast.showToast(
            msg: "${state.error?.response?.data['message']}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }
      },
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${widget.tour.name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    _chipSuggest(context),
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
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
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
                                    DateFormat('dd-MM-yyyy')
                                        .format(selectedDate),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                                      List<PricingTicketEntity> list = [];
                                      list.add(adultTicket);
                                      if (childrenTicket != null &&
                                          childrenTicket !=
                                              const PricingTicketModel()) {
                                        list.add(childrenTicket!);
                                      }
                                      showPricingInfoDialog(list);
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Chip(
                                            side: BorderSide.none,
                                            labelPadding:
                                                const EdgeInsets.all(0),
                                            label: Text(
                                              "Buy for discount",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: secondaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow: TextOverflow
                                                          .ellipsis),
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

                            _buildTicket(
                              context,
                              pricingTiket: adultTicket,
                              countTicket: _adult,
                              totalPrice:
                                  calculateTotalPrice(adultTicket, _adult),
                              add: () {
                                setState(() {
                                  _adult++;
                                  _totalPriceAdult =
                                      calculateTotalPrice(adultTicket, _adult) *
                                          _adult;
                                });
                              },
                              sub: () {
                                setState(() {
                                  if (_adult > 1) {
                                    _adult--;
                                    _totalPriceAdult = calculateTotalPrice(
                                            adultTicket, _adult) *
                                        _adult;
                                  }
                                });
                              },
                            ),

                            // Kiểm tra xem vé trẻ em có tồn tại không trước khi hiển thị
                            if (childrenTicket != null &&
                                childrenTicket != const PricingTicketModel())
                              _buildTicket(
                                context,
                                pricingTiket: childrenTicket!,
                                countTicket: _children,
                                totalPrice: calculateTotalPrice(
                                    childrenTicket!, _children),
                                add: () {
                                  setState(() {
                                    _children++;
                                    if (_children > 0) {
                                      _totalPriceChildren = calculateTotalPrice(
                                              childrenTicket!, _children) *
                                          _children;
                                    }
                                  });
                                },
                                sub: () {
                                  setState(() {
                                    if (_children > 0) {
                                      _children--;
                                      _children == 0
                                          ? _totalPriceChildren = 0
                                          : _totalPriceChildren =
                                              calculateTotalPrice(
                                                      childrenTicket!,
                                                      _children) *
                                                  _children;
                                    }
                                  });
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
              Container(
                height: 100,
              ),
              _buttonCheck(context),
            ],
          ),
        ),
      ),
    );
  }

  int calculateTotalPrice(PricingTicketEntity ticket, int count) {
    // Lấy ra giá của vé dựa trên số lượng vé và khoảng giá
    final priceRange = ticket.priceRange ?? [];
    for (var range in priceRange) {
      if (count >= range.fromAmount! && count <= range.toAmount!) {
        return range.price!;
      }
    }
    // Nếu không tìm thấy khoảng giá phù hợp, trả về giá mặc định
    return ticket.fromPrice != null ? int.parse(ticket.fromPrice!) : 0;
  }

  ListTile _buildTicket(
    BuildContext context, {
    required PricingTicketEntity pricingTiket,
    required int countTicket,
    required int totalPrice,
    required Function() add,
    required Function() sub,
  }) {
    return ListTile(
      title: Row(
        children: [
          Text(
            pricingTiket.ticket?.name ?? "ticket name",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            " (${pricingTiket.fromAge} - ${pricingTiket.toAge})",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w400),
          )
        ],
      ),
      subtitle: totalPrice > 0
          ? Row(
              children: [
                Text(
                  "${NumberFormatter.format(totalPrice)}₫ ",
                ),
                const Text(
                  "/person",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            )
          : Text(
              "From ${NumberFormatter.format(num.parse(pricingTiket.fromPrice!))}₫",
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
              sub();
            },
          ),
          Text(
            "$countTicket",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: () {
              add();
            },
          ),
        ],
      ),
    );
  }

  PricingTicketEntity filterTicket(List<PricingTicketEntity> allTickets,
      DateTime selectDate, int ticketTypeId) {
    // Lọc các PricingTicket dựa trên ticketTypeId
    List<PricingTicketEntity> filteredTickets = allTickets
        .where((ticket) => ticket.ticketTypeId == ticketTypeId)
        .toList();

    // Tách list thành hai: một list với is_default bằng false và một list với is_default bằng true
    List<PricingTicketEntity> falseDefaultTickets = filteredTickets
        .where((ticket) => ticket.isDefault != null && !ticket.isDefault!)
        .toList();

    List<PricingTicketEntity> trueDefaultTickets = filteredTickets
        .where((ticket) => ticket.isDefault != null && ticket.isDefault!)
        .toList();

    // Truncate selectDate to compare only the dates
    DateTime truncatedSelectDate = truncateTime(selectDate);

    // Kiểm tra xem có ticket nào thỏa mãn điều kiện không trong list is_default bằng false
    PricingTicketEntity? selectedTicket;

    for (var ticket in falseDefaultTickets) {
      // Nếu selectDate có trong danh sách applyDate
      if (ticket.applyDate != null &&
          ticket.applyDate!.map(truncateTime).contains(truncatedSelectDate)) {
        selectedTicket = ticket;
        break;
      }
    }

    // Nếu không tìm thấy ticket cho selectDate trong danh sách is_default bằng false,
    // thì trả về phần tử đầu tiên trong danh sách is_default bằng true
    selectedTicket ??= trueDefaultTickets.isNotEmpty
        ? trueDefaultTickets.first
        : getDefaultTicket();

    return selectedTicket;
  }

  PricingTicketModel getDefaultTicket() {
    return const PricingTicketModel();
  }

  // Đặt giờ, phút, giây về 0 để so sánh theo ngày
  DateTime truncateTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  Future<void> _initializeSelectedDate() async {
    List<DateTime> validDates = _getValidDates();
    validDates.sort((a, b) => a.compareTo(b));
    if (validDates.isNotEmpty) {
      setState(() {
        selectedDate = validDates.first;
        returnDate =
            selectedDate.add(Duration(days: widget.tour.duration! - 1));
        timeSlot = getSelectedTimeSlot(selectedDate);
      });
    }
  }

  Future<void> _selectDate() async {
    List<DateTime> validDates = _getValidDates();
    validDates.sort((a, b) => a.compareTo(b));
    if (validDates.isNotEmpty) {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: validDates.first,
        lastDate: validDates.last,
        selectableDayPredicate: (DateTime day) {
          return validDates
                  .any((date) => truncateTime(date) == truncateTime(day)) &&
              day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
        },
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          returnDate =
              selectedDate.add(Duration(days: widget.tour.durationDay!));
          timeSlot = getSelectedTimeSlot(picked);
          adultTicket =
              filterTicket(widget.tour.pricingTicket!, selectedDate, 1);
          if (filterTicket(widget.tour.pricingTicket!, selectedDate, 2) !=
              const PricingTicketModel()) {
            childrenTicket =
                filterTicket(widget.tour.pricingTicket!, selectedDate, 2);
          }
          _totalPriceAdult = calculateTotalPrice(adultTicket, _adult) * _adult;
        });
      }
    } else {
      Fluttertoast.showToast(
        msg: "Oops, looks like there's no valid date",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  List<DateTime> _getValidDates() {
    DateTime currentDate = DateTime.now();
    List<TourAvailabilityEntity>? tourAvailability =
        widget.tour.tourAvailability;
    List<DateTime> validDates = [];

    if (tourAvailability != null && tourAvailability.isNotEmpty) {
      for (var availability in tourAvailability) {
        if (availability.status?.toUpperCase() == "ACTIVE") {
          DateTime startDate = availability.validityDateRangeFrom!;
          DateTime endDate = availability.validityDateRangeTo!;
          for (var date = startDate;
              date.isBefore(endDate.add(const Duration(days: 1)));
              date = date.add(const Duration(days: 1))) {
            if (availability.weekdays!.any((weekday) =>
                    date.weekday ==
                        convertApiWeekdayToFlutterWeekday(weekday.day!) &&
                    (date.isAfter(currentDate) ||
                        date.isAtSameMomentAs(currentDate))) &&
                (widget.tour.blockDate == null ||
                    !widget.tour.blockDate!.contains(date))) {
              validDates.add(date);
            }
          }
        } else {
          return validDates;
        }
      }
    }
    return validDates;
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

  Wrap _chipSuggest(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        Chip(
          label: Text(
            "Free cancellation before ${widget.tour.refundBefore} days",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          backgroundColor: fourthColor,
        ),
        Chip(
          label: Text(
            "Best choice",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          backgroundColor: fourthColor,
        ),
      ],
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Booking Options',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        flexibleSpace: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  Positioned _buttonCheck(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        // color: whiteColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Total: "),
                Text(
                  "${NumberFormatter.format(_totalPriceAdult + _totalPriceChildren)}₫ ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            ElevatedButtonCustom(
              onPressed: () {
                context.read<PaymentBloc>().add(CheckAvailable(
                    widget.tour.id!, _adult, _children, selectedDate));
              },
              text: tBookTour,
            ),
          ],
        ),
      ),
    );
  }
}
