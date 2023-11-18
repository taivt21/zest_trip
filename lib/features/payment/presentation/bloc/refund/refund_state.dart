part of 'refund_bloc.dart';

abstract class RefundState extends Equatable {
  final DioException? error;

  const RefundState({this.error});

  @override
  List<Object?> get props => [error];
}

final class RefundInitial extends RefundState {}

final class RequestRefundSuccess extends RefundState {}

final class RequestRefundFail extends RefundState {
  const RequestRefundFail(DioException e) : super(error: e);
}
