part of 'tour_vehicle_bloc.dart';

abstract class TourVehicleState extends Equatable {
  final List<TourVehicle>? tourVehicles;
  final DioException? error;

  const TourVehicleState({this.tourVehicles, this.error});

  @override
  List<Object?> get props => [tourVehicles, error];
}

final class TourVehicleInitial extends TourVehicleState {
  const TourVehicleInitial();
}

final class RemoteTourVehicleLoading extends TourVehicleState {
  const RemoteTourVehicleLoading();
}

final class RemoteTourVehicleDone extends TourVehicleState {
  const RemoteTourVehicleDone(List<TourVehicle> tourVehicles)
      : super(tourVehicles: tourVehicles);
}

final class RemoteTourvehicleError extends TourVehicleState {
  const RemoteTourvehicleError(DioException error) : super(error: error);
}
