// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';

import 'package:zest_trip/features/payment/domain/usecases/check_available_usecase.dart';
import 'package:zest_trip/features/payment/domain/usecases/create_booking.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CheckAvailableUseCase _availableUseCase;
  final CreateBookingUseCase _createBookingUseCase;
  PaymentBloc(
    this._availableUseCase,
    this._createBookingUseCase,
  ) : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {});

    on<CheckAvailable>((event, emit) async {
      emit(PaymentInitial());
      final dataState = await _availableUseCase.call(
          event.tourId, event.adult, event.children, event.date);
      if (dataState is DataSuccess) {
        emit(CheckSuccess(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(CheckFail(dataState.error!));
      }
    });
    on<CreateBooking>((event, emit) async {
      final dataState = await _createBookingUseCase.call(
          event.bookingEntity, event.redirectUrl ?? "", event.voucherId ?? -1);
      if (dataState is DataSuccess) {
        emit(BookTourSuccess(dataState.data));
      } else if (dataState is DataFailed) {
        emit(BookTourFail(dataState.error!));
      }
    });
  }
}
