import 'package:zest_trip/features/home/data/models/tour_model.dart';
import 'package:zest_trip/features/payment/data/models/ticket_on_booking_model.dart';
import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    String? id,
    String? note,
    String? tourId,
    String? userId,
    String? bookerName,
    String? bookerPhone,
    String? bookerEmail,
    String? paidPrice,
    String? originalPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? bookedDate,
    String? status,
    String? timeSlot,
    String? refundReason,
    String? refundAmount,
    String? refundImage,
    List<TicketOnBookingModel>? ticketOnBooking,
    TourModel? tour,
    bool? isReviewed,
    String? commissionRate,
    String? departureLocation,
    // Map<String, dynamic>? provider,
  }) : super(
          id: id,
          note: note,
          tourId: tourId,
          userId: userId,
          bookerName: bookerName,
          bookerEmail: bookerEmail,
          bookerPhone: bookerPhone,
          paidPrice: paidPrice,
          originalPrice: originalPrice,
          createdAt: createdAt,
          updatedAt: updatedAt,
          bookedDate: bookedDate,
          status: status,
          timeSlot: timeSlot,
          refundReason: refundReason,
          refundAmount: refundAmount,
          refundImage: refundImage,
          ticketOnBooking: ticketOnBooking,
          tour: tour,
          isReviewed: isReviewed,
          commissionRate: commissionRate,
          departureLocation: departureLocation,
          // provider: provider,
        );

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json["id"] ?? "bookingId",
      note: json['note'] ?? "",
      tourId: json['tour_id'] ?? "tourId",
      userId: json['user_id'] ?? "userId",
      bookerName: json['booker_name'] ?? "bookerName",
      bookerEmail: json['booker_email'] ?? "bookerEmail",
      bookerPhone: json['booker_phone'] ?? "bookerPhone",
      paidPrice: json['paid_price'],
      originalPrice: json['original_price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      bookedDate: DateTime.parse(json['booked_date']),
      status: json['status'],
      timeSlot: json['time_slot'] ?? "time_slot",
      refundReason: json['refund_reason'],
      refundAmount: json['refund_ammount'],
      refundImage: json['refund_image'] ?? "refund_image",
      ticketOnBooking: json['TicketOnBooking'] != null
          ? List<TicketOnBookingModel>.from(json['TicketOnBooking']
              .map((component) => TicketOnBookingModel.fromJson(component)))
          : [],
      tour: json.containsKey('BookingOnTour')
          ? TourModel.fromJson(json['BookingOnTour'])
          : null,
      isReviewed: json['is_tour_reviewed'],
      commissionRate: json['commission_rate'],
      departureLocation: json['departure_location'] ?? "",

      // provider: json['Provider'] != null
      //     ? (json['Provider'] as Map<String, dynamic>).map(
      //         (key, value) {
      //           return MapEntry(key, value);
      //         },
      //       )
      //     : {},
    );
  }
}
