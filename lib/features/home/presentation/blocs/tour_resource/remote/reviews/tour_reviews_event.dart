part of 'tour_reviews_bloc.dart';

sealed class TourReviewsEvent extends Equatable {
  const TourReviewsEvent();

  @override
  List<Object> get props => [];
}

class GetTourReviews extends TourReviewsEvent {
  final String tourId;
  const GetTourReviews(this.tourId);
}

class PostReview extends TourReviewsEvent {
  final String content;
  final int rating;
  final String tourId;

  const PostReview(this.content, this.rating, this.tourId);
}
