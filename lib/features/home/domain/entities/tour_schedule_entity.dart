import 'package:equatable/equatable.dart';

class TourScheduleEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? tourId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TourScheduleEntity({
    this.id,
    this.title,
    this.description,
    this.tourId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, title, description, tourId, createdAt, updatedAt];
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
