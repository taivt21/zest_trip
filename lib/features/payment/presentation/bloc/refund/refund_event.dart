part of 'refund_bloc.dart';

abstract class RefundEvent extends Equatable {
  const RefundEvent();

  @override
  List<Object> get props => [];
}

final class RequestRefundEvent extends RefundEvent {
  final String bookingId;
  final String reason;
  const RequestRefundEvent({required this.bookingId, required this.reason});
}
