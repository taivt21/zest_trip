import 'package:zest_trip/features/payment/data/models/ticket_on_booking_model.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    String? id,
    String? tourId,
    String? tourName,
    int? adult,
    int? children,
    int? totalPrice,
    DateTime? selectedDate,
    DateTime? returnDate,
    String? timeSlot,
    //booking return
    String? userId,
    String? bookingId,
    String? bookerName,
    String? bookerEmail,
    String? bookerPhone,
    String? note,
    String? paidPrice,
    String? originalPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? bookedDate,
    String? status,
    List<TicketOnBookingModel>? ticketOnBooking,
    String? refundAmount,
    String? refundImage,
    String? refundReason,
  }) : super(
          id: id,
          tourId: tourId,
          tourName: tourName,
          adult: adult,
          children: children,
          totalPrice: totalPrice,
          selectedDate: selectedDate,
          returnDate: returnDate,
          timeSlot: timeSlot,
          //booking return
          userId: userId,
          bookingId: bookingId,
          bookerName: bookerName,
          bookerEmail: bookerEmail,
          bookerPhone: bookerPhone,
          note: note,
          paidPrice: paidPrice,
          originalPrice: originalPrice,
          createdAt: createdAt,
          updatedAt: updatedAt,
          bookedDate: bookedDate,
          status: status,
          ticketOnBooking: ticketOnBooking,
          refundAmount: refundAmount,
          refundImage: refundImage,
          refundReason: refundReason,
        );

  factory BookingModel.fromJson(Map<String?, dynamic> json) {
    return BookingModel(
      id: json["id"] ?? "bookingId",
      tourId: json['tour_id'] ?? "tourId",
      tourName: json['tour_name'] ?? "tourName",
      adult: json['adult'] ?? "adult",
      children: json['children'] ?? "children",
      totalPrice: json['total_price'] ?? "totalPrice",
      selectedDate: DateTime.parse(json['selected_date']),
      returnDate: DateTime.parse(json['return_date']),
      timeSlot: json['timeSlot'] ?? "time_slot",
      //booking return
      userId: json['user_id'] ?? "userId",
      bookerName: json['booker_name'] ?? "bookerName",
      bookerEmail: json['booker_email'] ?? "bookerEmail",
      bookerPhone: json['booker_phone'] ?? "bookerPhone",
      note: json['note'] ?? "note",
      paidPrice: json['paid_price'],
      originalPrice: json['original_price'],
      // refundAmount: json['refund_amount'] ?? "",
      // refundImage: json['refund_image'] ?? "",
      // refundReason: json['refund_reason'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      bookedDate: DateTime.parse(json['booked_date']),
      status: json['status'],
      ticketOnBooking: (json['TicketOnBooking'])
          ?.map((ticket) => TicketOnBookingModel.fromJson(ticket))
          .toList(),
    );
  }
}
