import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_range_entity.dart';

class PricingTicketRangeModel extends PricingTicketRangeEntity {
  const PricingTicketRangeModel({
    int? price,
    int? toAmount,
    int? fromAmount,
  }) : super(price: price, fromAmount: fromAmount, toAmount: toAmount);

  factory PricingTicketRangeModel.fromJson(Map<String, dynamic> json) {
    return PricingTicketRangeModel(
      price: json["price"] ?? 0,
      fromAmount: json["from_amount"] ?? 0,
      toAmount: json["to_amount"] ?? 0,
    );
  }
}
