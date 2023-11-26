import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_rcm_location.dart';

part 'tour_recommend_search_event.dart';
part 'tour_recommend_search_state.dart';

class TourRecommendSearchBloc
    extends Bloc<TourRecommendSearchEvent, TourRecommendSearchState> {
  final GetTourRcmLocationUseCase _getTourRcmLocationUseCase;

  TourRecommendSearchBloc(this._getTourRcmLocationUseCase)
      : super(TourRecommendSearchInitial()) {
    on<TourRecommendSearchEvent>((event, emit) {});
    on<GetToursRcmSearch>((event, emit) async {
      final dataState = await _getTourRcmLocationUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetToursRcmLocationSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(GetToursRcmSearchFail(dataState.error!));
      }
    });
  }
}
