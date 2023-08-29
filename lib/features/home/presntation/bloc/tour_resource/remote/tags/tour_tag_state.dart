part of 'tour_tag_bloc.dart';

abstract class TourTagState extends Equatable {
  final List<TourTag>? tourTags;
  final DioException? error;

  const TourTagState({this.tourTags, this.error});

  @override
  List<Object?> get props => [tourTags, error];
}

class TourTagInitial extends TourTagState {
  const TourTagInitial();
}

class RemoteTourTagLoading extends TourTagState {
  const RemoteTourTagLoading();
}

class RemoteTourTagDone extends TourTagState {
  const RemoteTourTagDone(List<TourTag> tourTags)
      : super(tourTags: tourTags);
}

class RemoteTourTagError extends TourTagState {
  const RemoteTourTagError(DioException error) : super(error: error);
}
