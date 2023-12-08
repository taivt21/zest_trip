import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/analytic_tag.dart';

import '../../../domain/usecases/get_tour_rcm_tag.dart';

part 'tour_recommend_tag_event.dart';
part 'tour_recommend_tag_state.dart';

class TourRecommendTagBloc
    extends Bloc<TourRecommendTagEvent, TourRecommendTagState> {
  final GetTourRcmTagUseCase _getTourRcmTagUseCase;
  final AnaLyticTagUseCase _anaLyticTagUseCase;

  TourRecommendTagBloc(this._getTourRcmTagUseCase, this._anaLyticTagUseCase)
      : super(TourRecommendTagInitial()) {
    on<TourRecommendTagEvent>((event, emit) {});
    on<GetToursRcmTag>((event, emit) async {
      final dataState = await _getTourRcmTagUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetToursRcmTagSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(GetToursRcmTagFail(dataState.error!));
      }
    });

    on<AnalyticTag>((event, emit) async {
      final dataState = await _anaLyticTagUseCase.call(event.tags ?? {});

      if (dataState is DataSuccess) {
        emit(AnalyticTourRecommendTag());
      }
      if (dataState is DataFailed) {
        emit(GetToursRcmTagFail(dataState.error!));
      }
    });
  }
}
