// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/payment/domain/entities/ticket_on_booking_enitity.dart';

class InvoiceEntity extends Equatable {
  final String? id;
  final String? note;
  final String? tourId;
  final String? userId;
  final String? bookerName;
  final String? bookerPhone;
  final String? bookerEmail;
  final String? paidPrice;
  final String? originalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? bookedDate;
  final String? status;
  final String? timeSlot;
  final String? refundReason;
  final String? refundAmount;

  final List<TicketOnBookingEntity>? ticketOnBooking;
  final Map<String, dynamic>? tour;
  final Map<String, dynamic>? provider;
  // final BookingOnTourEntity? bookingOnTour;

  const InvoiceEntity({
    this.id,
    this.userId,
    this.tourId,
    this.timeSlot,
    this.bookerName,
    this.bookerEmail,
    this.bookerPhone,
    this.note,
    this.paidPrice,
    this.originalPrice,
    this.createdAt,
    this.updatedAt,
    this.bookedDate,
    this.status,
    this.refundReason,
    this.refundAmount,
    this.ticketOnBooking,
    this.tour,
    this.provider,
  });

  @override
  List<Object?> get props => [
        id,
        note,
        userId,
        tourId,
        bookerName,
        bookerEmail,
        bookerPhone,
        paidPrice,
        originalPrice,
        createdAt,
        updatedAt,
        bookedDate,
        status,
        timeSlot,
        refundReason,
        refundAmount,
        ticketOnBooking,
        tour,
        provider
      ];
}
