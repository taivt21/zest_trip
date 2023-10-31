import 'package:equatable/equatable.dart';

class TourScheduleDetailEntity extends Equatable {
  final int? id;
  final int? tourScheduleId;
  final String? title;
  final String? from;
  final String? to;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TourScheduleDetailEntity({
    this.id,
    this.tourScheduleId,
    this.title,
    this.from,
    this.to,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, title, description, from, to, tourScheduleId, createdAt, updatedAt];
}
