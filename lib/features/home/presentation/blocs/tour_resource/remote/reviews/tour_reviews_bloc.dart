import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_reviews.dart';
import 'package:zest_trip/features/home/domain/usecases/post_review.dart';

part 'tour_reviews_event.dart';
part 'tour_reviews_state.dart';

class TourReviewsBloc extends Bloc<TourReviewsEvent, TourReviewsState> {
  final GetReviewsUseCase _getReviewsUseCase;
  final PostReviewUseCase _postReviewUseCase;

  TourReviewsBloc(this._getReviewsUseCase, this._postReviewUseCase)
      : super(TourReviewsInitial()) {
    on<TourReviewsEvent>((event, emit) {});
    on<GetTourReviews>(
      (event, emit) async {
        final dataState = await _getReviewsUseCase.call(event.tourId);

        if (dataState is DataSuccess) {
          emit(GetReviewsSuccess(dataState.data!));
        }
        if (dataState is DataFailed) {
          emit(GetReviewsFail(dataState.error!));
        }
      },
    );

    on<PostReview>(((event, emit) async {
      final dataState = await _postReviewUseCase.call(
          event.content, event.rating, event.tourId);
      if (dataState is DataSuccess) {
        emit(const ReviewSuccess());
      } else if (dataState is DataFailed) {
        emit(ReviewFail(dataState.error!));
      }
    }));
  }
}
