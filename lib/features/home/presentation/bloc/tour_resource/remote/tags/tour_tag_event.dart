part of 'tour_tag_bloc.dart';

abstract class TourResourceEvent extends Equatable {
  const TourResourceEvent();

  @override
  List<Object> get props => [];
}

class GetTourTags extends TourResourceEvent {
  const GetTourTags();
}