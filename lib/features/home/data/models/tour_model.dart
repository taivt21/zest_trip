import 'package:zest_trip/features/home/data/models/tour_component_model.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

class TourModel extends TourEntity {
  const TourModel({
    String? id,
    String? providerUserId,
    String? name,
    String? description,
    String? footnote,
    List<String>? tourImages,
    double? price,
    int? durationDay,
    int? durationNight,
    String? location,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? addressName,
    String? addressCity,
    String? addressProvince,
    String? addressCountry,
    String? tourLocationType,
    List<TourComponentModel>? tourComponents,
    List<TourTag>? tags,
    List<TourVehicle>? vehicles,
  }) : super(
          id: id,
          providerUserId: providerUserId,
          name: name,
          description: description,
          footnote: footnote,
          tourImages: tourImages,
          price: price,
          durationDay: durationDay,
          durationNight: durationNight,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          addressName: addressName,
          addressCity: addressCity,
          addressProvince: addressProvince,
          addressCountry: addressCountry,
          tourLocationType: tourLocationType,
          tourComponents: tourComponents,
          tags: tags,
          vehicles: vehicles,
        );

  factory TourModel.fromJson(Map<String, dynamic> json) {
    final price = json['price'];
    final double parsedPrice = double.tryParse(price) ?? 0.0;
    return TourModel(
      id: json['id'] ?? "",
      providerUserId: json['provider_user_id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      footnote: json['footnote'] ?? "",
      tourImages: json['tour_images'] != null
          ? List<String>.from(json['tour_images'])
          : [],
      price: parsedPrice,
      durationDay: json['duration_day'] ?? 0,
      durationNight: json['duration_night'] ?? 0,
      status: json['status'] ?? "",
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']),
      addressName: json['address_name'] ?? "",
      addressCity: json['address_city'] ?? "",
      addressProvince: json['address_province'] ?? "",
      addressCountry: json['address_country'] ?? "",
      tourLocationType: json['tour_location_type'] ?? "",
      tourComponents: json['TourComponent'] != null
          ? List<TourComponentModel>.from(json['TourComponent']
              .map((component) => TourComponentModel.fromJson(component)))
          : [],
      tags: json['tag_id'] != null
          ? List<TourTag>.from(
              json['tag_id'].map((component) => TourTag.fromJson(component)))
          : [],
      vehicles: json['vehicle_id'] != null
          ? List<TourVehicle>.from(json['vehicle_id']
              .map((component) => TourVehicle.fromJson(component)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_user_id': providerUserId,
      'name': name,
      'description': description,
      'footnote': footnote,
      'tour_images': tourImages,
      'price': price,
      'duration_day': durationDay,
      'duration_night': durationNight,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'address_name': addressName,
      'address_city': addressCity,
      'address_province': addressProvince,
      'address_country': addressCountry,
      'TourComponent':
          tourComponents?.map((component) => component.toJson()).toList(),
      'tag_id': tags?.map((component) => component.toJson()).toList(),
      'vehicle_id': vehicles?.map((component) => component.toJson()).toList(),
    };
  }
}
