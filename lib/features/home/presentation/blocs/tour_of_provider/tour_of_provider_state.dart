// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_of_provider_bloc.dart';

abstract class TourProviderState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;
  final bool? hasMore;
  const TourProviderState({
    this.tours,
    this.error,
    this.hasMore,
  });

  @override
  List<Object?> get props => [tours, error, hasMore];
}

final class TourProviderInitial extends TourProviderState {}

final class GetTourProviderSuccess extends TourProviderState {
  const GetTourProviderSuccess({
    List<TourEntity>? tours,
    bool hasMore = false,
  }) : super(tours: tours, hasMore: hasMore);
}

final class GetTourProviderFail extends TourProviderState {
  const GetTourProviderFail(DioException e) : super(error: e);
}
