// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_sponsore_bloc.dart';

abstract class TourSponsoreState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;
  const TourSponsoreState({
    this.tours,
    this.error,
  });

  @override
  List<Object?> get props => [tours, error];
}

final class TourSponsoreInitial extends TourSponsoreState {}

final class GetToursSponsoreSuccess extends TourSponsoreState {
  const GetToursSponsoreSuccess(List<TourEntity> tours) : super(tours: tours);
}

final class GetToursSponsoreFail extends TourSponsoreState {
  const GetToursSponsoreFail(DioException e) : super(error: e);
}
