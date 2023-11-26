import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';
import 'package:zest_trip/features/home/domain/entities/provider_reply_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

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
  final ProviderReplyEntity? reply;
  final TourEntity? tour;

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
    this.reply,
    this.tour,
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
        reply,
        tour
      ];
}
