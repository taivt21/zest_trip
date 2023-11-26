// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

abstract class RemoteTourState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;
  final bool? hasMore;

  const RemoteTourState({
    this.tours,
    this.error,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [tours, error, hasMore];
}

final class RemoteTourLoading extends RemoteTourState {
  const RemoteTourLoading();
}

class RemoteTourDone extends RemoteTourState {
  const RemoteTourDone({
    List<TourEntity>? tours,
    bool hasMore = false,
  }) : super(tours: tours, hasMore: hasMore);

  // RemoteTourDone withMoreTours(List<TourEntity> moreTours) {
  //   return RemoteTourDone(
  //     tours: [...tours!, ...moreTours],
  //     hasMore: hasMore!,
  //   );
  // }
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
