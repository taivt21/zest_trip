// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
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
  final String? refundImage;
  final bool? isReviewed;
  final String? commissionRate;
  final String? departureLocation;

  final List<TicketOnBookingEntity>? ticketOnBooking;
  final TourEntity? tour;
  // final Map<String, dynamic>? provider;
  // final BookingOnTourEntity? bookingOnTour;

  const InvoiceEntity({
    this.id,
    this.note,
    this.tourId,
    this.userId,
    this.bookerName,
    this.bookerPhone,
    this.bookerEmail,
    this.paidPrice,
    this.originalPrice,
    this.createdAt,
    this.updatedAt,
    this.bookedDate,
    this.status,
    this.timeSlot,
    this.refundReason,
    this.refundAmount,
    this.refundImage,
    this.isReviewed,
    this.ticketOnBooking,
    this.tour,
    this.commissionRate,
    this.departureLocation,
    // this.provider,
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
        refundImage,
        ticketOnBooking,
        tour,
        // provider,
        isReviewed,
        commissionRate, departureLocation,
      ];
}
