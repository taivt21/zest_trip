abstract class RemoteTourEvent {
  const RemoteTourEvent();
}

class GetTours extends RemoteTourEvent {
  final String? search;
  final int? page;
  final int? limit;
  final String? orderBy;
  final Set<int>? tags;
  const GetTours({this.search, this.page, this.limit, this.orderBy, this.tags});
}

class GetToursWithTag extends RemoteTourEvent {
  const GetToursWithTag();
}

class AddToWishlist extends RemoteTourEvent {
  final String tourId;

  const AddToWishlist(this.tourId);
}
