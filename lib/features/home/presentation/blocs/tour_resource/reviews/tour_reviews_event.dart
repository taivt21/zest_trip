part of 'tour_reviews_bloc.dart';

abstract class TourReviewsEvent extends Equatable {
  const TourReviewsEvent();

  @override
  List<Object> get props => [];
}

class GetTourReviews extends TourReviewsEvent {
  final String tourId;
  const GetTourReviews(this.tourId);
}
