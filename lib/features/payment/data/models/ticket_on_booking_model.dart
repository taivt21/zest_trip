import 'package:zest_trip/features/payment/domain/entities/ticket_on_booking_enitity.dart';

class TicketOnBookingModel extends TicketOnBookingEntity {
  const TicketOnBookingModel({
    String? bookingId,
    int? quantity,
    String? originalPrice,
    String? paidPrice,
    int? ticketTypeId,
  }) : super(
            bookingId: bookingId,
            quantity: quantity,
            originalPrice: originalPrice,
            paidPrice: paidPrice,
            ticketTypeId: ticketTypeId);

  factory TicketOnBookingModel.fromJson(Map<String, dynamic> json) {
    return TicketOnBookingModel(
      bookingId: json['booking_id'],
      quantity: json['quantity'],
      originalPrice: json['original_price'],
      paidPrice: json['paid_price'],
      ticketTypeId: json['ticket_type_id'],
    );
  }
}
