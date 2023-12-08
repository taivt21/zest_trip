import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_own_review_usecase.dart';
import 'package:zest_trip/features/payment/domain/usecases/post_review.dart';

part 'my_review_event.dart';
part 'my_review_state.dart';

class MyReviewBloc extends Bloc<MyReviewEvent, MyReviewState> {
  final PostReviewUseCase _postReviewUseCase;
  final GetOwnReviewUseCase _getOwnReviewUseCase;

  MyReviewBloc(this._postReviewUseCase, this._getOwnReviewUseCase)
      : super(MyReviewInitial()) {
    on<MyReviewEvent>((event, emit) {});
    on<PostReview>(((event, emit) async {
      final dataState = await _postReviewUseCase.call(
          event.content, event.rating, event.tourId);
      if (dataState is DataSuccess) {
        emit(const ReviewSuccess());
      } else if (dataState is DataFailed) {
        emit(ReviewFail(dataState.error!));
      }
    }));

    on<GetMyReview>(((event, emit) async {
      final dataState = await _getOwnReviewUseCase.call();
      if (dataState is DataSuccess) {
        emit(GetReviewSuccess(dataState.data ?? []));
      } else if (dataState is DataFailed) {
        emit(GetReviewFail(dataState.error!));
      }
    }));
  }
}
