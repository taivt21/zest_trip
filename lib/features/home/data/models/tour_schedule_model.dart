import 'package:zest_trip/features/home/data/models/tour_schedule_detail_model.dart';
import 'package:zest_trip/features/home/domain/entities/tour_schedule_entity.dart';

class TourScheduleModel extends TourScheduleEntity {
  const TourScheduleModel({
    final int? id,
    final String? title,
    final String? tourId,
    final String? description,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final List<TourScheduleDetailModel>? tourScheduleDetails,
  }) : super(
          id: id,
          title: title,
          description: description,
          tourId: tourId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          tourScheduleDetails: tourScheduleDetails,
        );

  factory TourScheduleModel.fromJson(Map<String, dynamic> json) {
    return TourScheduleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      tourId: json['tour_id'],
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
      tourScheduleDetails: json['TourScheduleDetail'] != null
          ? List<TourScheduleDetailModel>.from(json['TourScheduleDetail']
              .map((component) => TourScheduleDetailModel.fromJson(component)))
          : [],
    );
  }
}
