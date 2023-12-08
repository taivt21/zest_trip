// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  final Map<String, dynamic>? payment;
  final DioException? error;

  const PaymentState({this.error, this.payment});

  @override
  List<Object?> get props => [error];
}

final class PaymentInitial extends PaymentState {}

final class CheckSuccess extends PaymentState {
  const CheckSuccess(Map<String, dynamic> payment) : super(payment: payment);
}

final class CheckFail extends PaymentState {
  const CheckFail(DioException e) : super(error: e);
}

final class BookTourFail extends PaymentState {
  const BookTourFail(DioException e) : super(error: e);
}

final class BookTourSuccess extends PaymentState {
  final String url;
  const BookTourSuccess(this.url);
}

final class RequestRefund extends PaymentState {}

final class RefundSuccess extends PaymentState {}

final class RefundFail extends PaymentState {}
