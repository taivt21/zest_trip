part of 'location_popular_bloc.dart';

abstract class LocationPopularEvent extends Equatable {
  const LocationPopularEvent();

  @override
  List<Object> get props => [];
}

class GetPopularLocation extends LocationPopularEvent {
  const GetPopularLocation();
}
