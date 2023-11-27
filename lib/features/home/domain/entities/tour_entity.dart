import 'package:equatable/equatable.dart';

import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_schedule_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_availability_entity.dart';

class TourEntity extends Equatable {
  final String? id;
  final String? providerId;
  final String? name;
  final String? description;
  final String? footnote;
  final List<String>? tourImages;
  final double? price;
  final int? duration;
  final int? durationDay;
  final int? durationNight;
  final int? bookBefore;
  final int? refundBefore;
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
  final List<TourAvailabilityEntity>? tourAvailability;
  // final List<TourReview> tourReviews;
  final List<PricingTicketEntity>? pricingTicket;
  final String? avgRating;
  final Map<String, dynamic>? count;
  final Map<String, dynamic>? departureLocation;

  const TourEntity({
    this.id,
    this.providerId,
    this.name,
    this.description,
    this.footnote,
    this.tourImages,
    this.price,
    this.duration,
    this.bookBefore,
    this.refundBefore,
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
    this.tourAvailability,
    this.pricingTicket,
    this.avgRating,
    this.count,
    this.durationDay,
    this.durationNight,
    this.departureLocation,
  });

  @override
  List<Object?> get props => [
        id,
        providerId,
        name,
        description,
        footnote,
        tourImages,
        price,
        duration,
        durationDay,
        durationNight,
        bookBefore,
        refundBefore,
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
        pricingTicket,
        avgRating,
        count,
        departureLocation
      ];
}
