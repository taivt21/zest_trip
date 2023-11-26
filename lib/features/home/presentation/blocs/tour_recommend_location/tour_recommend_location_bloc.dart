import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/analytic_location.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_rcm_location.dart';

part 'tour_recommend_location_event.dart';
part 'tour_recommend_location_state.dart';

class TourRecommendLocationBloc
    extends Bloc<TourRecommendLocationEvent, TourRecommendLocationState> {
  final GetTourRcmLocationUseCase _getTourRcmLocationUseCase;
  final AnaLyticLocationUseCase _anaLyticLocationUseCase;

  TourRecommendLocationBloc(
      this._getTourRcmLocationUseCase, this._anaLyticLocationUseCase)
      : super(TourRecommendTagInitial()) {
    on<TourRecommendLocationEvent>((event, emit) {});
    on<GetToursRcmLocation>((event, emit) async {
      final dataState = await _getTourRcmLocationUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetToursRcmLocationSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(GetToursRcmLocationFail(dataState.error!));
      }
    });
    on<AnalyticLocation>((event, emit) async {
      final dataState =
          await _anaLyticLocationUseCase.call(event.locations ?? {});

      if (dataState is DataSuccess) {
        emit(AnalyticTourRecommendLoction());
      }
      if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(GetToursRcmLocationFail(dataState.error!));
      }
    });
  }
}
