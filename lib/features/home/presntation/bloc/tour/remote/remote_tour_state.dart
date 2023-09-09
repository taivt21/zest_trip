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

class RemoteTourLoading extends RemoteTourState {
  const RemoteTourLoading();
}

class RemoteTourDone extends RemoteTourState {
  const RemoteTourDone(List<TourEntity> tour) : super(tours: tour);
}

class RemoteTourError extends RemoteTourState {
  const RemoteTourError(DioException error) : super(error: error);
}

class AddingToWishlist extends RemoteTourState {
  const AddingToWishlist() : super();
}

//wishlist
class AddedToWishlist extends RemoteTourState {
  const AddedToWishlist() : super();
}

class AddToWishlistError extends RemoteTourState {
  const AddToWishlistError(DioException error) : super(error: error);
}
