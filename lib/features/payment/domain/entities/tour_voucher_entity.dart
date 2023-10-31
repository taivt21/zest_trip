import 'package:equatable/equatable.dart';

import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

class TourVoucher extends Equatable {
  final String? id;

  final String? providerId;

  final String? label;

  final String? description;

  final int? type;

  final String? discountAmount;

  final double? minimumPrice;

  final String? totalVoucherCount;

  final int? usedVoucherCount;

  final List<TourTag>? allowedTags;

  final List<TourEntity>? allowedTours;

  final String? createBy;

  final DateTime? createdAt;

  final DateTime? expireDate;

  final DateTime? updatedAt;

  final String? status;

  const TourVoucher({
    this.id,
    required this.providerId,
    this.label,
    this.description,
    this.type,
    this.discountAmount,
    this.minimumPrice,
    this.totalVoucherCount,
    this.usedVoucherCount,
    this.allowedTags,
    this.allowedTours,
    this.createBy,
    this.createdAt,
    this.expireDate,
    this.updatedAt,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        providerId,
        label,
        description,
        type,
        discountAmount,
        minimumPrice,
        totalVoucherCount,
        usedVoucherCount,
        allowedTags,
        allowedTours,
        createBy,
        createdAt,
        expireDate,
        updatedAt,
        status,
      ];
}
