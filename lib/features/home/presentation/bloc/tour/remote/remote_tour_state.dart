import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

abstract class RemoteTourState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;

  const RemoteTourState({this.tours, this.error});

  @override
  List<Object?> get props => [tours, error];
}

final class RemoteTourLoading extends RemoteTourState {
  const RemoteTourLoading();
}

final class RemoteTourDone extends RemoteTourState {
  const RemoteTourDone(List<TourEntity> tour) : super(tours: tour);
}

final class RemoteTourError extends RemoteTourState {
  const RemoteTourError(DioException error) : super(error: error);
}

//wishlist
final class AddedToWishlist extends RemoteTourState {
  const AddedToWishlist() : super();
}

final class AddToWishlistError extends RemoteTourState {
  const AddToWishlistError(DioException error) : super(error: error);
}

//Review
final class ReviewSuccess extends RemoteTourState {
  const ReviewSuccess();
}

final class ReviewFail extends RemoteTourState {
  const ReviewFail(DioException error) : super(error: error);
}
