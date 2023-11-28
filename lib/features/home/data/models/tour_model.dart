import 'package:zest_trip/features/home/data/models/provider_model.dart';
import 'package:zest_trip/features/home/data/models/tour_schedule_model.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/payment/data/models/pricing_ticket_model.dart';
import 'package:zest_trip/features/payment/data/models/tour_availability_model.dart';

class TourModel extends TourEntity {
  const TourModel({
    String? id,
    String? providerId,
    String? name,
    String? description,
    String? footnote,
    List<String>? tourImages,
    int? duration,
    int? durationDay,
    int? durationNight,
    String? location,
    int? bookBefore,
    int? refundBefore,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? addressName,
    String? addressDistrict,
    String? addressWard,
    String? addressCity,
    String? addressProvince,
    String? addressCountry,
    String? tourLocationType,
    List<TourScheduleModel>? tourSchedule,
    List<TourAvailabilityModel>? tourAvailability,
    List<TourTag>? tags,
    List<TourVehicle>? vehicles,
    ProviderModel? provider,
    List<PricingTicketModel>? pricingTicket,
    String? avgRating,
    Map<String, dynamic>? count,
    Map<String, dynamic>? departureLocation,
  }) : super(
          id: id,
          providerId: providerId,
          name: name,
          description: description,
          footnote: footnote,
          tourImages: tourImages,
          duration: duration,
          durationDay: durationDay,
          durationNight: durationNight,
          bookBefore: bookBefore,
          refundBefore: refundBefore,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          addressName: addressName,
          addressDistrict: addressDistrict,
          addressWard: addressWard,
          addressCity: addressCity,
          addressProvince: addressProvince,
          addressCountry: addressCountry,
          tourLocationType: tourLocationType,
          tourSchedule: tourSchedule,
          tags: tags,
          tourAvailability: tourAvailability,
          vehicles: vehicles,
          provider: provider,
          pricingTicket: pricingTicket,
          avgRating: avgRating,
          count: count,
          departureLocation: departureLocation,
        );

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json.containsKey('id') ? json['id'] : "",
      providerId: json.containsKey('provider_id') ? json['provider_id'] : "",
      name: json.containsKey('name') ? json['name'] : "",
      description: json.containsKey('description') ? json['description'] : "",
      footnote: json.containsKey('footnote') ? json['footnote'] : "",
      tourImages: json.containsKey('tour_images') && json['tour_images'] != null
          ? List<String>.from(json['tour_images'])
          : [],
      duration: json.containsKey('duration') ? json['duration'] : 0,
      durationDay: json.containsKey('duration_day') ? json['duration_day'] : 0,
      durationNight:
          json.containsKey('duration_night') ? json['duration_night'] : 0,
      bookBefore: json.containsKey('book_before') ? json['book_before'] : 0,
      refundBefore:
          json.containsKey('refund_before') ? json['refund_before'] : 0,
      status: json.containsKey('status') ? json['status'] : "",
      createdAt: json.containsKey('created_at')
          ? DateTime.tryParse(json['created_at'] ?? "")
          : null,
      updatedAt: json.containsKey('updated_at')
          ? DateTime.tryParse(json['updated_at'] ?? "")
          : null,
      addressName: json.containsKey('address_name') ? json['address_name'] : "",
      addressDistrict:
          json.containsKey('address_district') ? json['address_district'] : "",
      addressWard: json.containsKey('address_ward') ? json['address_ward'] : "",
      addressProvince:
          json.containsKey('address_province') ? json['address_province'] : "",
      addressCountry:
          json.containsKey('address_country') ? json['address_country'] : "",
      tourLocationType: json.containsKey('tour_location_type')
          ? json['tour_location_type']
          : "",
      tourSchedule:
          json.containsKey('TourSchedule') && json['TourSchedule'] != null
              ? List<TourScheduleModel>.from(json['TourSchedule']
                  .map((component) => TourScheduleModel.fromJson(component)))
              : [],
      tags: json.containsKey('tag_id') && json['tag_id'] != null
          ? List<TourTag>.from(
              json['tag_id'].map((component) => TourTag.fromJson(component)))
          : [],
      vehicles: json.containsKey('vehicle_id') && json['vehicle_id'] != null
          ? List<TourVehicle>.from(json['vehicle_id']
              .map((component) => TourVehicle.fromJson(component)))
          : [],
      provider: json.containsKey('Provider')
          ? ProviderModel.fromJson(json['Provider'])
          : null,
      pricingTicket:
          json.containsKey('TicketPricing') && json['TicketPricing'] != null
              ? List<PricingTicketModel>.from(json['TicketPricing']
                  .map((component) => PricingTicketModel.fromJson(component)))
              : [],
      tourAvailability: json.containsKey('TourAvailability') &&
              json['TourAvailability'] != null
          ? List<TourAvailabilityModel>.from(json['TourAvailability']
              .map((component) => TourAvailabilityModel.fromJson(component)))
          : [],
      avgRating:
          json.containsKey("avgRating") ? json["avgRating"].toString() : "",
      count: json.containsKey('_count')
          ? (json['_count'] as Map<String, dynamic>).map(
              (key, value) {
                return MapEntry(key, value);
              },
            )
          : {},
      departureLocation: json.containsKey('departure_location')
          ? (json['departure_location'] as Map<String, dynamic>).map(
              (key, value) {
                return MapEntry(key, value);
              },
            )
          : {},
    );
  }
}
