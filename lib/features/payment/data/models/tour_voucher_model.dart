import 'package:zest_trip/features/payment/domain/entities/tour_voucher_entity.dart';

class TourVoucherModel extends TourVoucherEntity {
  const TourVoucherModel({
    String? id,
    String? name,
    double? discount,
    String? discountType,
    int? quantity,
    int? quantityUsed,
    String? tourId,
    DateTime? createdAt,
    DateTime? expiredDate,
    DateTime? updatedAt,
    String? status,
    Map<String, dynamic>? applyCondition,
  }) : super(
            id: id,
            name: name,
            discount: discount,
            discountType: discountType,
            quantity: quantity,
            quantityUsed: quantityUsed,
            tourId: tourId,
            createdAt: createdAt,
            expiredDate: expiredDate,
            updatedAt: updatedAt,
            status: status,
            applyConditions: applyCondition);
  // factory TourVoucherModel.fromJson(Map<String, dynamic> json) {
  //   // final voucherList = json['data']['voucher'] as List<dynamic>;
  //   final voucherList = json['data'] as List<dynamic>;

  //   final vouchers = voucherList
  //       .map((voucherJson) =>
  //           TourVoucherModel._fromJson(voucherJson as Map<String, dynamic>))
  //       .toList();

  //   return vouchers.isNotEmpty
  //       ? vouchers.first
  //       : const TourVoucherModel(); // Return the first voucher for simplicity
  // }

  factory TourVoucherModel.fromJson(Map<String, dynamic> json) {
    return TourVoucherModel(
      id: json['id'],
      name: json['name'],
      discount: json['discount'],
      discountType: json['discount_type'],
      quantity: json['quantity'],
      quantityUsed: json['quantity_used'],
      tourId: json['tour_id'],
      expiredDate: DateTime.parse(json['expired_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      applyCondition: json['apply_condition'] != null
          ? (json['apply_condition'] as Map<String, dynamic>).map(
              (key, value) {
                return MapEntry(key, value);
              },
            )
          : {},
    );
  }
}
