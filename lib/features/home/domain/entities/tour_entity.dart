import 'package:equatable/equatable.dart';

import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_schedule_entity.dart';

class TourEntity extends Equatable {
  final String? id;
  final String? providerUserId;
  final String? name;
  final String? description;
  final String? footnote;
  final List<String>? tourImages;
  final int? price;
  final int? duration;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? addressName;
  final String? addressDistrict;
  final String? addressCity;
  final String? addressProvince;
  final String? addressCountry;
  final String? tourLocationType;
  final List<TourScheduleEntity>? tourSchedule;
  final List<TourTag>? tags;
  final List<TourVehicle>? vehicles;
  final ProviderEntity? provider;

  const TourEntity({
    this.id,
    this.providerUserId,
    this.name,
    this.description,
    this.footnote,
    this.tourImages,
    this.price,
    this.duration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.addressName,
    this.addressDistrict,
    this.addressCity,
    this.addressProvince,
    this.addressCountry,
    this.tourLocationType,
    this.tourSchedule,
    this.tags,
    this.vehicles,
    this.provider,
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
        duration,
        status,
        createdAt,
        updatedAt,
        addressName,
        addressDistrict,
        addressCity,
        addressProvince,
        addressCountry,
        tourLocationType,
        tourSchedule,
        tags,
        vehicles,
        provider,
      ];
}
