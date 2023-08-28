import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/tour_component_entity.dart';

class TourEntity extends Equatable {
  final String? id;
  final String? providerUserId;
  final String? name;
  final String? description;
  final String? footnote;
  final List<String>? tourImages;
  final double? price;
  final int? durationDay;
  final int? durationNight;
  final String? location;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TourComponentEntity>? tourComponents;
  final List<TourTag>? tags;
  final List<TourVehicle>? vehicle;

  const TourEntity({
    this.id,
    this.providerUserId,
    this.name,
    this.description,
    this.footnote,
    this.tourImages,
    this.price,
    this.durationDay,
    this.durationNight,
    this.location,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.tourComponents,
    this.tags,
    this.vehicle,
  });

  @override
  List<Object?> get props => [
        id,
        providerUserId,
        name,
        description,
        footnote,
        tourImages,
        price,
        durationDay,
        durationNight,
        location,
        status,
        createdAt,
        updatedAt,
        tourComponents,
        tags,
        vehicle
      ];
}
