// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_recommend_location_bloc.dart';

abstract class TourRecommendLocationState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;
  const TourRecommendLocationState({
    this.tours,
    this.error,
  });

  @override
  List<Object?> get props => [tours, error];
}

final class TourRecommendTagInitial extends TourRecommendLocationState {}

final class GetToursRcmLocationSuccess extends TourRecommendLocationState {
  const GetToursRcmLocationSuccess(List<TourEntity> tours)
      : super(tours: tours);
}

final class GetToursRcmLocationFail extends TourRecommendLocationState {
  const GetToursRcmLocationFail(DioException e) : super(error: e);
}

final class AnalyticTourRecommendLoction extends TourRecommendLocationState {}
