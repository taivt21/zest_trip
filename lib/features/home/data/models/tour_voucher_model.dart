import 'package:zest_trip/features/home/data/models/tour_model.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_voucher_entity.dart';

class TourVoucherModel extends TourVoucher {
  const TourVoucherModel({
    String? id,
    String? providerId,
    String? label,
    String? description,
    int? type,
    String? discounAmmount,
    double? minimumPrice,
    String? totalVoucherCount,
    int? usedVoucherCount,
    List<TourTag>? allowedTags,
    List<TourEntity>? allowedTours,
    String? createBy,
    DateTime? createdAt,
    DateTime? expireDate,
    DateTime? updatedAt,
    String? status,
  }) : super(
          id: id,
          providerId: providerId,
          label: label,
          description: description,
          type: type,
          discounAmmount: discounAmmount,
          minimumPrice: minimumPrice,
          totalVoucherCount: totalVoucherCount,
          usedVoucherCount: usedVoucherCount,
          allowedTags: allowedTags,
          allowedTours: allowedTours,
          createBy: createBy,
          createdAt: createdAt,
          expireDate: expireDate,
          updatedAt: updatedAt,
          status: status,
        );

  factory TourVoucherModel.fromJson(Map<String, dynamic> json) {
    return TourVoucherModel(
      id: json['id'],
      providerId: json['provider_id'],
      label: json['label'],
      description: json['description'],
      type: json['type'],
      discounAmmount: json['discoun_ammount'],
      minimumPrice: json['minimum_price'],
      totalVoucherCount: json['total_voucher_count'],
      usedVoucherCount: json['used_voucher_count'],
      createBy: json['createBy'],
      createdAt: DateTime.parse(json['createdAt']),
      expireDate: DateTime.parse(json['expireDate']),
      updatedAt: DateTime.parse(json['updatedAt']) ,
      status: json['status'],
      allowedTags: json['allowed_tags'] != null
          ? List<TourTag>.from(
              json['tag_id'].map(
                (component) => TourTag.fromJson(component),
              ),
            )
          : [],
      allowedTours: json['allowed_tours'] != null
          ? List<TourModel>.from(
              json['tag_id'].map(
                (component) => TourModel.fromJson(component),
              ),
            )
          : [],
    );
  }
}
