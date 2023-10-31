abstract class RemoteTourEvent {
  const RemoteTourEvent();
}

class GetTours extends RemoteTourEvent {
  const GetTours();
}

class GetToursWithTag extends RemoteTourEvent {
  const GetToursWithTag();
}

class AddToWishlist extends RemoteTourEvent {
  final String tourId;

  const AddToWishlist(this.tourId);
}

class PostReview extends RemoteTourEvent {
  final String content;
  final int rating;
  final String tourId;

  PostReview(this.content, this.rating, this.tourId);
}
