part of 'tour_detail_bloc.dart';

abstract class TourDetailEvent extends Equatable {
  const TourDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTourDetail extends TourDetailEvent {
  final String tourId;
  const GetTourDetail(this.tourId);
}
