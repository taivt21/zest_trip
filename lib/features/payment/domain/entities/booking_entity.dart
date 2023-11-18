// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/payment/domain/entities/ticket_on_booking_enitity.dart';

class BookingEntity extends Equatable {
  final String? id;
  final String? tourId;
  final String? tourName;
  final int? adult;
  final int? children;
  final int? totalPrice;
  final DateTime? selectedDate;
  final DateTime? returnDate;
  final String? timeSlot;

  final String? bookingId;
  final String? userId;
  final String? bookerName;
  final String? bookerEmail;
  final String? bookerPhone;
  final String? note;
  final String? paidPrice;
  final String? originalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? bookedDate;
  final String? status;
  final List<TicketOnBookingEntity>? ticketOnBooking;
  // final BookingOnTourEntity? bookingOnTour;

  const BookingEntity(
      {this.tourId,
      this.id,
      this.tourName,
      this.adult,
      this.children,
      this.totalPrice,
      this.selectedDate,
      this.returnDate,
      this.timeSlot,
      //booking return
      this.userId,
      this.bookingId,
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
      this.ticketOnBooking});

  @override
  List<Object?> get props => [
        id,
        tourId,
        tourName,
        adult,
        children,
        totalPrice,
        selectedDate,
        returnDate,
        timeSlot
      ];
}
