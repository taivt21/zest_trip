part of 'voucher_bloc.dart';

abstract class VoucherState extends Equatable {
  final DioException? error;
  final List<TourVoucherEntity>? vouchers;
  const VoucherState({this.error, this.vouchers});

  @override
  List<Object?> get props => [error];
}

final class VoucherInitial extends VoucherState {}

final class GetVoucherSuccess extends VoucherState {
  const GetVoucherSuccess(List<TourVoucherEntity> vouchers)
      : super(vouchers: vouchers);
}

final class GetVoucherFail extends VoucherState {
  const GetVoucherFail(DioException e) : super(error: e);
}
