import 'package:zest_trip/features/home/domain/entities/tour_schedule_entity.dart';

class TourScheduleModel extends TourScheduleEntity {
  const TourScheduleModel({
    final int? id,
    final String? title,
    final String? tourId,
    final String? description,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          tourId: tourId,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TourScheduleModel.fromJson(Map<String, dynamic> json) {
    return TourScheduleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      tourId: json['tour_id'],
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tour_id': tourId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}