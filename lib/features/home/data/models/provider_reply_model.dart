import 'package:zest_trip/features/home/domain/entities/provider_reply_entity.dart';

class ProviderReplyModel extends ProviderReplyEntity {
  const ProviderReplyModel({
    String? id,
    String? userId,
    String? reviewId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) : super(
          id: id,
          userId: userId,
          reviewId: reviewId,
          content: content,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ProviderReplyModel.fromJson(Map<String, dynamic> json) {
    return ProviderReplyModel(
      id: json['id'],
      userId: json['user_id'],
      reviewId: json['review_id'],
      content: json['content'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
