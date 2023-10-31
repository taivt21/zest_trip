import 'package:equatable/equatable.dart';

class TourReviewEntity extends Equatable {
  final String? id;
  final String? userId;

  final String? tourId;

  final String? description;

  final int? rating;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String? status;

  const TourReviewEntity({
    this.id,
    this.userId,
    this.tourId,
    this.rating,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        tourId,
        rating,
        description,
        createdAt,
        updatedAt,
        status,
      ];
}
