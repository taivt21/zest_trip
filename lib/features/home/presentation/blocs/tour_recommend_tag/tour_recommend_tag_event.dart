part of 'tour_recommend_tag_bloc.dart';

abstract class TourRecommendTagEvent extends Equatable {
  const TourRecommendTagEvent();

  @override
  List<Object> get props => [];
}

class GetToursRcmTag extends TourRecommendTagEvent {
  const GetToursRcmTag();
}

class AnalyticTag extends TourRecommendTagEvent {
  final Set<int>? tags;
  const AnalyticTag({this.tags});
}
