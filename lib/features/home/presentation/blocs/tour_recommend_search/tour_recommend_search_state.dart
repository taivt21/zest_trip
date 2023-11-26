// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_recommend_search_bloc.dart';

abstract class TourRecommendSearchState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;
  const TourRecommendSearchState({
    this.tours,
    this.error,
  });

  @override
  List<Object?> get props => [tours, error];
}

final class TourRecommendSearchInitial extends TourRecommendSearchState {}

final class GetToursRcmLocationSuccess extends TourRecommendSearchState {
  const GetToursRcmLocationSuccess(List<TourEntity> tours)
      : super(tours: tours);
}

final class GetToursRcmSearchFail extends TourRecommendSearchState {
  const GetToursRcmSearchFail(DioException e) : super(error: e);
}
