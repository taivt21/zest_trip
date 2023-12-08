// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_wishlist_bloc.dart';

abstract class TourWishlistState extends Equatable {
  final List<TourEntity>? tours;
  final DioException? error;
  const TourWishlistState({
    this.tours,
    this.error,
  });

  @override
  List<Object?> get props => [tours, error];
}

final class TourWishlistInitial extends TourWishlistState {}

final class GetToursWishlistSuccess extends TourWishlistState {
  const GetToursWishlistSuccess(List<TourEntity> tours) : super(tours: tours);
}

final class GetToursWishlistFail extends TourWishlistState {
  const GetToursWishlistFail(DioException e) : super(error: e);
}

final class AddedWishlist extends TourWishlistState {}

final class RemovedWishlist extends TourWishlistState {}

final class WishlistFail extends TourWishlistState {}
