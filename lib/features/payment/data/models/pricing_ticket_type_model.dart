import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_type_entity.dart';

class PricingTypeModel extends PricingTypeEntity {
  const PricingTypeModel({
    int? id,
    String? name,
  }) : super(
          id: id,
          name: name,
        );

  factory PricingTypeModel.fromJson(Map<String, dynamic> json) {
    return PricingTypeModel(
      id: json["id"],
      name: json["name"],
    );
  }
}
