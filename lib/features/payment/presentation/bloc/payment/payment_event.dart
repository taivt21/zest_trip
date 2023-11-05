// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class CheckAvailable extends PaymentEvent {
  final String tourId;
  final int adult;
  final int children;
  final DateTime date;

  const CheckAvailable(this.tourId, this.adult, this.children, this.date);
}

class CreateBooking extends PaymentEvent {
  final String name;
  final String phone;
  final String email;
  final int adult;
  final int children;
  final DateTime selectDate;
  final String tourId;
  final String? redirectUrl;
  const CreateBooking({
    required this.name,
    required this.phone,
    required this.email,
    required this.adult,
    required this.children,
    required this.selectDate,
    required this.tourId,
    this.redirectUrl,
  });
}
