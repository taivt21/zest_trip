import 'package:equatable/equatable.dart';

class TourVoucherEntity extends Equatable {
  final int? id;
  final String? name;
  final String? discount;
  final String? discountType;
  final int? quantity;
  final int? quantityUsed;
  final String? tourId;
  final DateTime? createdAt;
  final DateTime? expiredDate;
  final DateTime? updatedAt;
  final String? status;
  final Map<String, dynamic>? applyConditions;

  const TourVoucherEntity(
      {this.id,
      this.name,
      this.discount,
      this.discountType,
      this.quantity,
      this.quantityUsed,
      this.tourId,
      this.createdAt,
      this.expiredDate,
      this.updatedAt,
      this.status,
      this.applyConditions});

  @override
  List<Object?> get props => [
        id,
        name,
        discount,
        discountType,
        quantity,
        quantityUsed,
        tourId,
        createdAt,
        expiredDate,
        updatedAt,
        status,
        applyConditions
      ];
}
