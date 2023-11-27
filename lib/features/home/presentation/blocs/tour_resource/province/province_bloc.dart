import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/province_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_province.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final GetProvinceUseCase _getProvinceUseCase;
  ProvinceBloc(this._getProvinceUseCase) : super(ProvinceInitial()) {
    on<ProvinceEvent>((event, emit) {});
    on<GetProvinces>(
      (event, emit) async {
        final dataState = await _getProvinceUseCase.call();

        if (dataState is DataSuccess) {
          emit(GetProvinceSuccess(dataState.data!));
        }
        if (dataState is DataFailed) {
          emit(GetProvinceFail(dataState.error!));
        }
      },
    );
  }
}
