import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/usecases/get_popular_location.dart';

part 'location_popular_event.dart';
part 'location_popular_state.dart';

class LocationPopularBloc
    extends Bloc<LocationPopularEvent, LocationPopularState> {
  final GetPopularLocationUseCase _getPopularLocationUseCase;
  LocationPopularBloc(this._getPopularLocationUseCase)
      : super(LocationPopularInitial()) {
    on<LocationPopularEvent>((event, emit) {});
    on<GetPopularLocation>((event, emit) async {
      final dataState = await _getPopularLocationUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetPopularLocationSuccess(dataState.data ?? []));
      }
      if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(GetPopularLocationFail(dataState.error!));
      }
    });
  }
}
