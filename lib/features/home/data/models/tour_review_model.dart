import 'package:zest_trip/features/authentication/data/models/auth_user_model.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';

class TourReviewModel extends TourReviewEntity {
  const TourReviewModel({
    String? id,
    String? userId,
    String? tourId,
    String? description,
    int? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
    AuthUserModel? user,
    String? status,
  }) : super(
            id: id,
            userId: userId,
            tourId: tourId,
            description: description,
            rating: rating,
            user: user,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status);

  factory TourReviewModel.fromJson(Map<String, dynamic> json) {
    return TourReviewModel(
      id: json["id"],
      tourId: json["tour_id"],
      userId: json["user_id"],
      rating: json["rating"],
      description: json["content"],
      user: AuthUserModel.fromJson(json['user']),
    );
  }
}
