import 'package:equatable/equatable.dart';

class TicketOnBookingEntity extends Equatable {
  final String? bookingId;
  final int? quantity;
  final String? originalPrice;
  final String? paidPrice;
  final int? ticketTypeId;

  const TicketOnBookingEntity({
    this.bookingId,
    this.quantity,
    this.originalPrice,
    this.paidPrice,
    this.ticketTypeId,
  });

  @override
  List<Object?> get props =>
      [bookingId, quantity, originalPrice, paidPrice, ticketTypeId];
}
