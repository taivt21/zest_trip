import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_rcm_search.dart';

part 'tour_recommend_search_event.dart';
part 'tour_recommend_search_state.dart';

class TourRecommendSearchBloc
    extends Bloc<TourRecommendSearchEvent, TourRecommendSearchState> {
  final GetTourRcmSearchUseCase _getTourRcmSearchUseCase;

  TourRecommendSearchBloc(this._getTourRcmSearchUseCase)
      : super(TourRecommendSearchInitial()) {
    on<TourRecommendSearchEvent>((event, emit) {});
    on<GetToursRcmSearch>((event, emit) async {
      final dataState = await _getTourRcmSearchUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetToursRcmLocationSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(GetToursRcmSearchFail(dataState.error!));
      }
    });
  }
}
