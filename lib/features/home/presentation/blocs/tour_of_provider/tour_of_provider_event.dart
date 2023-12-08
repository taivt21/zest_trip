part of 'tour_of_provider_bloc.dart';

abstract class TourProviderEvent extends Equatable {
  const TourProviderEvent();

  @override
  List<Object> get props => [];
}

class GetTourProvider extends TourProviderEvent {
  final String providerId;
  final String? search;
  final int? page;
  final int? limit;
  final String? orderBy;
  final Set<int>? tags;
  final Set<int>? vehicles;
  final String? province;
  final String? district;
  const GetTourProvider(
    this.providerId, {
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

class ClearTourProvider extends TourProviderEvent {
  const ClearTourProvider();
}
