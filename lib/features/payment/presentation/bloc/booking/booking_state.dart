// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  final List<InvoiceEntity>? bookings;
  final DioException? error;
  const BookingState({this.error, this.bookings});

  @override
  List<Object?> get props => [error, bookings];
}

final class BookingInitial extends BookingState {}

final class GetBookingSuccess extends BookingState {
  const GetBookingSuccess(List<InvoiceEntity> bookings)
      : super(bookings: bookings);
}

final class GetBookingFail extends BookingState {
  const GetBookingFail(DioException e) : super(error: e);
}
