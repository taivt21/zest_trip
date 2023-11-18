part of 'tour_reviews_bloc.dart';

abstract class TourReviewsState extends Equatable {
  final List<TourReviewEntity>? reviews;
  final DioException? error;

  const TourReviewsState({this.reviews, this.error});

  @override
  List<Object?> get props => [reviews, error];
}

final class TourReviewsInitial extends TourReviewsState {}

final class GetReviewsSuccess extends TourReviewsState {
  const GetReviewsSuccess(List<TourReviewEntity> reviews)
      : super(reviews: reviews);
}

final class GetReviewsFail extends TourReviewsState {
  const GetReviewsFail(DioException e) : super(error: e);
}
//Review