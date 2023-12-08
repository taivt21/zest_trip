// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_detail_bloc.dart';

abstract class TourDetailState extends Equatable {
  final TourEntity? tour;
  final DioException? error;
  const TourDetailState({
    this.tour,
    this.error,
  });

  @override
  List<Object?> get props => [tour, error];
}

final class TourDetailInitial extends TourDetailState {}

final class GetTourDetailSuccess extends TourDetailState {
  const GetTourDetailSuccess(TourEntity tour) : super(tour: tour);
}

final class GetTourDetailFail extends TourDetailState {
  const GetTourDetailFail(DioException e) : super(error: e);
}
