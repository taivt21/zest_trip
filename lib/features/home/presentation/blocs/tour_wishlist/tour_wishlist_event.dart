// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tour_wishlist_bloc.dart';

abstract class TourWishlistEvent extends Equatable {
  const TourWishlistEvent();

  @override
  List<Object> get props => [];
}

class AddWishlist extends TourWishlistEvent {
  final String tourId;
  const AddWishlist(
    this.tourId,
  );
}

class RemoveWishlist extends TourWishlistEvent {
  final String tourId;
  const RemoveWishlist(
    this.tourId,
  );
}

class GetWishlist extends TourWishlistEvent {
  const GetWishlist();
}
