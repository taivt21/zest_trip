import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/home/domain/entities/tour_schedule_detail_entity.dart';

class TourScheduleEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? tourId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TourScheduleDetailEntity>? tourScheduleDetails;

  const TourScheduleEntity({
    this.id,
    this.title,
    this.description,
    this.tourId,
    this.createdAt,
    this.updatedAt,
    this.tourScheduleDetails,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        tourId,
        createdAt,
        updatedAt,
        tourScheduleDetails,
      ];

}
