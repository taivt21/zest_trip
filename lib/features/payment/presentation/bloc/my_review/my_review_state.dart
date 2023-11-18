part of 'my_review_bloc.dart';

abstract class MyReviewState extends Equatable {
  final DioException? error;
  const MyReviewState({this.error});

  @override
  List<Object?> get props => [error];
}

final class MyReviewInitial extends MyReviewState {}

final class ReviewSuccess extends MyReviewState {
  const ReviewSuccess();
}

final class ReviewFail extends MyReviewState {
  const ReviewFail(DioException error) : super(error: error);
}

final class GetMyReviewInitial extends MyReviewState {}

final class GetReviewSuccess extends MyReviewState {
  final List<TourReviewEntity> reviews;
  const GetReviewSuccess(this.reviews);
}

final class GetReviewFail extends MyReviewState {
  const GetReviewFail(DioException error) : super(error: error);
}
