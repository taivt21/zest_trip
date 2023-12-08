import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/usecases/report_provider.dart';

part 'report_provider_event.dart';
part 'report_provider_state.dart';

class ReportProviderBloc
    extends Bloc<ReportProviderEvent, ReportProviderState> {
  final ReportProviderUseCase _reportProviderUseCase;

  ReportProviderBloc(this._reportProviderUseCase)
      : super(ReportProviderInitial()) {
    on<ReportProviderEvent>((event, emit) {});
    on<ReportProvider>((event, emit) async {
      emit(ReportProviderInitial());
      final dataState = await _reportProviderUseCase.call(
          event.providerId, event.reason, event.type);
      if (dataState is DataSuccess) {
        emit(ReportProviderSuccess());
      } else if (dataState is DataFailed) {
        emit(ReportProviderFail(dataState.error!));
      }
    });
  }
}
