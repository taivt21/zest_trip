import 'package:equatable/equatable.dart';

class ProviderReplyEntity extends Equatable {
  final String? id;
  final String? content;
  final String? userId;
  final String? reviewId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProviderReplyEntity({
    this.id,
    this.content,
    this.userId,
    this.reviewId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        reviewId,
        content,
        createdAt,
        updatedAt,
      ];
}
