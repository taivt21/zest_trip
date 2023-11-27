import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_info_provider_usecase.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final GetInfoProviderUseCase _getInfoProviderUseCase;
  ProviderBloc(this._getInfoProviderUseCase) : super(ProviderInitial()) {
    on<ProviderEvent>((event, emit) {});
    on<GetProviderEvent>(
      (event, emit) async {
        
        final dataState = await _getInfoProviderUseCase.call(event.providerId);
        if (dataState is DataSuccess) {
          emit(GetInfoProviderSuccess(dataState.data!));
        }
        if (dataState is DataFailed) {
          print(dataState.error?.response?.data["message"]);
          emit(GetInfoProviderFail(dataState.error!));
        }
      },
    );
  }
}
