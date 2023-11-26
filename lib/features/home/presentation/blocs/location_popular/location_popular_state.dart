part of 'location_popular_bloc.dart';

abstract class LocationPopularState extends Equatable {
  final List<dynamic>? locations;
  final DioException? error;
  const LocationPopularState({this.locations, this.error});

  @override
  List<Object?> get props => [locations, error];
}

final class LocationPopularInitial extends LocationPopularState {}

final class GetPopularLocationSuccess extends LocationPopularState {
  const GetPopularLocationSuccess(List<dynamic> locations)
      : super(locations: locations);
}

final class GetPopularLocationFail extends LocationPopularState {
  const GetPopularLocationFail(DioException e) : super(error: e);
}
