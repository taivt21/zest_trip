part of 'my_review_bloc.dart';

abstract class MyReviewEvent extends Equatable {
  const MyReviewEvent();

  @override
  List<Object> get props => [];
}

class GetMyReview extends MyReviewEvent {}

class PostReview extends MyReviewEvent {
  final String content;
  final int rating;
  final String tourId;

  const PostReview(this.content, this.rating, this.tourId);
}
