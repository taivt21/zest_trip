import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';

class TourReviewEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? tourId;
  final String? description;
  final int? rating;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final AuthUser? user;
  final String? status;
  final Map<String, dynamic>? replies;

  const TourReviewEntity({
    this.id,
    this.userId,
    this.user,
    this.tourId,
    this.rating,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.replies,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        tourId,
        user,
        rating,
        description,
        createdAt,
        updatedAt,
        status,
        replies
      ];
}
