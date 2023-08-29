// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? addressName;
  final String? addressCity;
  final String? addressProvince;
  final String? addressCountry;
  final String? tourLocationType;
  final List<TourComponentEntity>? tourComponents;
  final List<TourTag>? tags;
  final List<TourVehicle>? vehicles;

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
    this.status,
    this.createdAt,
    this.updatedAt,
    this.addressName,
    this.addressCity,
    this.addressProvince,
    this.addressCountry,
    this.tourLocationType,
    this.tourComponents,
    this.tags,
    this.vehicles,
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
        status,
        createdAt,
        updatedAt,
        addressName,
        addressCity,
        addressProvince,
        addressCountry,
        tourLocationType,
        tourComponents,
        tags,
        vehicles
      ];
}
