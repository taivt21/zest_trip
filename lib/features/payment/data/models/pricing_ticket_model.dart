import 'package:zest_trip/features/payment/data/models/ticket_model.dart';
import 'package:zest_trip/features/payment/data/models/pricing_ticket_range_model.dart';
import 'package:zest_trip/features/payment/data/models/pricing_ticket_type_model.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_entity.dart';

class PricingTicketModel extends PricingTicketEntity {
  const PricingTicketModel({
    int? ticketTypeId,
    String? tourId,
    int? pricingTypeId,
    int? minimumBookingQuantity,
    int? maximumBookingQuantity,
    int? minimumTicketCount,
    int? maximumTicketCount,
    String? fromAge,
    String? toAge,
    String? fromPrice,
    String? toPrice,
    List<PricingTicketRangeModel>? priceRange,
    PricingTypeModel? pricingType,
    TicketModel? ticket,
    bool? isDefault,
    List<DateTime>? applyDate,
  }) : super(
          ticketTypeId: ticketTypeId,
          tourId: tourId,
          pricingTypeId: pricingTypeId,
          minimumBookingQuantity: minimumBookingQuantity,
          maximumBookingQuantity: maximumBookingQuantity,
          minimumTicketCount: minimumTicketCount,
          maximumTicketCount: maximumTicketCount,
          fromAge: fromAge,
          toAge: toAge,
          fromPrice: fromPrice,
          toPrice: toPrice,
          priceRange: priceRange,
          pricingType: pricingType,
          ticket: ticket,
          isDefault: isDefault,
          applyDate: applyDate,
        );

  factory PricingTicketModel.fromJson(Map<String, dynamic> json) {
    return PricingTicketModel(
      ticketTypeId: json['ticket_type_id'] ?? 0,
      tourId: json['tour_id'] ?? "",
      pricingTypeId: json['pricing_type_id'] ?? 0,
      minimumBookingQuantity: json['minimum_booking_quantity'] ?? 0,
      maximumBookingQuantity: json['maximum_booking_quantity'] ?? 0,
      minimumTicketCount: json['minimum_ticket_count'] ?? 0,
      maximumTicketCount: json['maximum_ticket_count'] ?? 0,
      fromAge: json['from_age'] ?? "",
      toAge: json['to_age'] ?? "",
      fromPrice: json['from_price'] ?? "",
      toPrice: json['to_price'] ?? "",
      priceRange: json['price_range'] != null
          ? List<PricingTicketRangeModel>.from(json['price_range']
              .map((component) => PricingTicketRangeModel.fromJson(component)))
          : [],
      pricingType: PricingTypeModel.fromJson(json['PricingType'] ?? {}),
      ticket: TicketModel.fromJson(json['Ticket'] ?? {}),
      isDefault: json['is_default'],
      applyDate: json.containsKey('apply_dates') &&
              json['apply_dates'] != null &&
              json['apply_dates'].isNotEmpty
          ? List<DateTime>.from(
              json['apply_dates'].map((date) => DateTime.tryParse(date)))
          : [],
    );
  }
}
