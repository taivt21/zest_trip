// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';

import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_own_booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetOwnBookingUseCase _getOwnBookingUseCase;
  BookingBloc(
    this._getOwnBookingUseCase,
  ) : super(BookingInitial()) {
    on<BookingEvent>((event, emit) async {
      emit(BookingInitial());

      final dataState = await _getOwnBookingUseCase.call();
      if (dataState is DataSuccess) {
        emit(GetBookingSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(GetBookingFail(dataState.error!));
      }
    });
  }
}
