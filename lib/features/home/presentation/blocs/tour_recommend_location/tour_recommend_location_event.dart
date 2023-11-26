part of 'tour_recommend_location_bloc.dart';

abstract class TourRecommendLocationEvent extends Equatable {
  const TourRecommendLocationEvent();

  @override
  List<Object> get props => [];
}

class GetToursRcmLocation extends TourRecommendLocationEvent {
  const GetToursRcmLocation();
}

class AnalyticLocation extends TourRecommendLocationEvent {
  final Set<String>? locations;
  const AnalyticLocation({this.locations});
}
