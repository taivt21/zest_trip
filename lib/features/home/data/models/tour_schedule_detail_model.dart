import 'package:zest_trip/features/home/domain/entities/tour_schedule_detail_entity.dart';

class TourScheduleDetailModel extends TourScheduleDetailEntity {
  const TourScheduleDetailModel({
    final int? id,
    final int? tourScheduleId,
    final String? title,
    final String? description,
    final String? from,
    final String? to,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) : super(
          id: id,
          tourScheduleId: tourScheduleId,
          title: title,
          from: from,
          to: to,
          description: description,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TourScheduleDetailModel.fromJson(Map<String, dynamic> json) {
    return TourScheduleDetailModel(
      id: json['id'],
      tourScheduleId: json['tour_schedule_id'],
      title: json['title'],
      description: json['description'],
      from: json['from'],
      to: json['to'],
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }
}
