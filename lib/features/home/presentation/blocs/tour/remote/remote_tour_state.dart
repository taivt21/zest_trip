import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

abstract class RemoteTourState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;

  const RemoteTourState({
    this.tours,
    this.error,
  });

  @override
  List<Object?> get props => [
        tours,
        error,
      ];
}

final class RemoteTourLoading extends RemoteTourState {
  const RemoteTourLoading();
}

class RemoteTourDone extends RemoteTourState {
  @override
  final List<TourEntity> tours;
  final bool hasMore;
  const RemoteTourDone({required this.tours, required this.hasMore});

  RemoteTourDone withMoreTours(List<TourEntity> moreTours) {
    return RemoteTourDone(
      tours: [...tours, ...moreTours],
      hasMore: moreTours.isNotEmpty,
    );
  }
}

final class RemoteTourError extends RemoteTourState {
  const RemoteTourError(DioException error) : super(error: error);
}

final class NoMoreToLoad extends RemoteTourState {
  const NoMoreToLoad();
}

//wishlist
final class AddedToWishlist extends RemoteTourState {
  const AddedToWishlist() : super();
}

final class AddToWishlistError extends RemoteTourState {
  const AddToWishlistError(DioException error) : super(error: error);
}
