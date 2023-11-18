part of 'voucher_bloc.dart';

abstract class VoucherEvent extends Equatable {
  const VoucherEvent();

  @override
  List<Object> get props => [];
}

final class GetVoucher extends VoucherEvent {
  final String tourId;

  const GetVoucher(this.tourId);
}
