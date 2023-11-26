part of 'tour_recommend_search_bloc.dart';

abstract class TourRecommendSearchEvent extends Equatable {
  const TourRecommendSearchEvent();

  @override
  List<Object> get props => [];
}

class GetToursRcmSearch extends TourRecommendSearchEvent {
  const GetToursRcmSearch();
}
