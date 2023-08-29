import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/usecases/get_vehicles.dart';

part 'tour_vehicle_event.dart';
part 'tour_vehicle_state.dart';

class TourVehicleBloc extends Bloc<TourVehicleEvent, TourVehicleState> {
  final GetTourVehiclesUseCase _getTourVehiclesUseCase;
  TourVehicleBloc(this._getTourVehiclesUseCase)
      : super(const RemoteTourVehicleLoading()) {
    on<TourVehicleEvent>((event, emit) async {
      final dataState = await _getTourVehiclesUseCase.call();

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        emit(RemoteTourVehicleDone(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(RemoteTourvehicleError(dataState.error!));
      }
    });
  }
}
