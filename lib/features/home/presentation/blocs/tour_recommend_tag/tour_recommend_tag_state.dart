// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_recommend_tag_bloc.dart';

abstract class TourRecommendTagState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;
  const TourRecommendTagState({
    this.tours,
    this.error,
  });

  @override
  List<Object?> get props => [tours, error];
}

final class TourRecommendTagInitial extends TourRecommendTagState {}

final class GetToursRcmTagSuccess extends TourRecommendTagState {
  const GetToursRcmTagSuccess(List<TourEntity> tours) : super(tours: tours);
}

final class GetToursRcmTagFail extends TourRecommendTagState {
  const GetToursRcmTagFail(DioException e) : super(error: e);
}

final class AnalyticTourRecommendTag extends TourRecommendTagState {}
