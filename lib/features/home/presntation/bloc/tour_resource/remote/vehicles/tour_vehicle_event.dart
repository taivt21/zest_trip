part of 'tour_vehicle_bloc.dart';

abstract class TourVehicleEvent extends Equatable {
  const TourVehicleEvent();

  @override
  List<Object> get props => [];
}

class GetTourVehicles extends TourVehicleEvent {
  const GetTourVehicles();
}
