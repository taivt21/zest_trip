part of 'checking_tour_bloc.dart';

abstract class CheckingTourEvent extends Equatable {
  const CheckingTourEvent();

  @override
  List<Object> get props => [];
}

class CheckingTour extends CheckingTourEvent {
  final String tourId;
  const CheckingTour(this.tourId);
}
