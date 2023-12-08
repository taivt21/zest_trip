import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_check_booking_entity.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_pricing_tour.dart';

part 'checking_tour_event.dart';
part 'checking_tour_state.dart';

class CheckingTourBloc extends Bloc<CheckingTourEvent, CheckingTourState> {
  final GetPricingTourUseCase _getPricingTourUseCase;
  CheckingTourBloc(this._getPricingTourUseCase) : super(CheckingTourInitial()) {
    on<CheckingTourEvent>((event, emit) {});
    on<CheckingTour>(
      (event, emit) async {
        emit(CheckingTourInitial());
        final dataState = await _getPricingTourUseCase.call(event.tourId);
        if (dataState is DataSuccess) {
          emit(CheckingTourSuccess(dataState.data!));
        } else if (dataState is DataFailed) {
          emit(CheckingTourFail(dataState.error!));
        }
      },
    );
  }
}
