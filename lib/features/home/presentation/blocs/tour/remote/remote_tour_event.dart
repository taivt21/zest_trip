// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class RemoteTourEvent {
  const RemoteTourEvent();
}

class GetTours extends RemoteTourEvent {
  final String? search;
  final int? page;
  final int? limit;
  final String? orderBy;
  final Set<int>? tags;
  final Set<int>? vehicles;
  final String? province;
  final String? district;
  const GetTours({
    this.search,
    this.page,
    this.limit,
    this.orderBy,
    this.tags,
    this.vehicles,
    this.province,
    this.district,
  });
}

class GetToursWithTag extends RemoteTourEvent {
  const GetToursWithTag();
}

class ClearTour extends RemoteTourEvent {
  const ClearTour();
}

class AddToWishlist extends RemoteTourEvent {
  final String tourId;

  const AddToWishlist(this.tourId);
}
