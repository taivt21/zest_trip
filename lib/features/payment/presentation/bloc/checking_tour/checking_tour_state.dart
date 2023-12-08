part of 'checking_tour_bloc.dart';

abstract class CheckingTourState extends Equatable {
  final DioException? error;
  final TourCheckBookingEntity? tourChecking;
  const CheckingTourState({this.error, this.tourChecking});

  @override
  List<Object?> get props => [error, tourChecking];
}

final class CheckingTourInitial extends CheckingTourState {}

final class CheckingTourSuccess extends CheckingTourState {
  const CheckingTourSuccess(TourCheckBookingEntity tourChecking)
      : super(tourChecking: tourChecking);
}

final class CheckingTourFail extends CheckingTourState {
  const CheckingTourFail(DioException error) : super(error: error);
}
