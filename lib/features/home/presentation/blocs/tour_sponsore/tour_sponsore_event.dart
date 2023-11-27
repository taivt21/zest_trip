part of 'tour_sponsore_bloc.dart';

abstract class TourSponsoreEvent extends Equatable {
  const TourSponsoreEvent();

  @override
  List<Object> get props => [];
}

class GetToursSponsore extends TourSponsoreEvent {
  const GetToursSponsore();
}

