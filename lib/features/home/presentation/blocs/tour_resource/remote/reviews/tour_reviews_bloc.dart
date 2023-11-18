import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_reviews_tour.dart';

part 'tour_reviews_event.dart';
part 'tour_reviews_state.dart';

class TourReviewsBloc extends Bloc<TourReviewsEvent, TourReviewsState> {
  final GetReviewsUseCase _getReviewsUseCase;

  TourReviewsBloc(this._getReviewsUseCase) : super(TourReviewsInitial()) {
    on<TourReviewsEvent>((event, emit) {});
    on<GetTourReviews>(
      (event, emit) async {
        emit(TourReviewsInitial());
        final dataState = await _getReviewsUseCase.call(event.tourId);

        if (dataState is DataSuccess) {
          emit(GetReviewsSuccess(dataState.data!));
        }
        if (dataState is DataFailed) {
          emit(GetReviewsFail(dataState.error!));
        }
      },
    );
  }
}
