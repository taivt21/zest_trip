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
    String? status,
  }) : super(
            id: id,
            userId: userId,
            tourId: tourId,
            description: description,
            rating: rating,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status);

  factory TourReviewModel.fromJson(Map<String, dynamic> json) {
    return TourReviewModel(
      userId: json["userId"] ?? "",
      rating: json["rating"] ?? 0,
      description: json["content"] ?? "",
      id: json["reviewId"] ?? "",
    );
  }
}
