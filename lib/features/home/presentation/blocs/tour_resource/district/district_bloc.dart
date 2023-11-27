import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/district_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_district.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final GetDistrictUseCase _getDistrictUseCase;
  DistrictBloc(this._getDistrictUseCase) : super(DistrictInitial()) {
    on<DistrictEvent>((event, emit) {});
    on<GetDistricts>(
      (event, emit) async {
        final dataState = await _getDistrictUseCase.call();

        if (dataState is DataSuccess) {
          emit(GetDistrictSuccess(dataState.data!));
        }
        if (dataState is DataFailed) {
          emit(GetDistrictFail(dataState.error!));
        }
      },
    );
  }
}
