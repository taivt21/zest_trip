import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

class TourModel extends TourEntity {
  const TourModel({
    String? id,
    String? userIdProvider,
    String? tourDescription,
    String? tourHighlights,
    String? tourFootnote,
    String? tourComponents,
    String? duration,
    String? location,
    String? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) : super(
          id: id,
          userIdProvider: userIdProvider,
          tourDescription: tourDescription,
          tourHighlights: tourHighlights,
          tourFootnote: tourFootnote,
          tourComponents: tourComponents,
          duration: duration,
          location: location,
          tags: tags,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'] ?? "",
      userIdProvider: json['userIdProvider'] ?? "",
      tourDescription: json['tourDescription'] ?? "",
      tourHighlights: json['tourHighlights'] ?? "",
      tourFootnote: json['tourFootnote'] ?? "",
      tourComponents: json['tourComponents'] ?? "",
      duration: json['duration'] ?? "",
      location: json['location'] ?? "",
      tags: json['tags'],
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']),
      status: json['status'] ?? "",
    );
  }
  // factory TourModel.fromJson(Map<String, dynamic> json) =>
  //     _$TourModelFromJson(json);

  factory TourModel.fromEntity(TourEntity entity) {
    return TourModel(
      id: entity.id,
      userIdProvider: entity.userIdProvider,
      tourDescription: entity.tourDescription,
      tourHighlights: entity.tourHighlights,
      tourFootnote: entity.tourFootnote,
      tourComponents: entity.tourComponents,
      duration: entity.duration,
      location: entity.location,
      tags: entity.tags,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userIdProvider': userIdProvider,
        'tourDescription': tourDescription,
        'tourHighlights': tourHighlights,
        'tourFootnote': tourFootnote,
        'tourComponents': tourComponents,
        'duration': duration,
        'location': location,
        'tags': tags,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'status': status,
      };
}
