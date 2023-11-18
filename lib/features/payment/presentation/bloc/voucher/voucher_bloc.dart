// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_voucher_entity.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_voucher_of_tour.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final GetVoucherOfTourUseCase _getVoucherOfTourUseCase;
  VoucherBloc(
    this._getVoucherOfTourUseCase,
  ) : super(VoucherInitial()) {
    on<VoucherEvent>((event, emit) {});
    on<GetVoucher>((event, emit) async {
      emit(VoucherInitial());
      final dataState = await _getVoucherOfTourUseCase.call(event.tourId);
      if (dataState is DataSuccess) {
        emit(GetVoucherSuccess(dataState.data!));
      } else if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(GetVoucherFail(dataState.error!));
      }
    });
  }
}
