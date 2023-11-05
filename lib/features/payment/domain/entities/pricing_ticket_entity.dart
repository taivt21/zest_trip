import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_range_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_type_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/ticket_entity.dart';

class PricingTicketEntity extends Equatable {
  final int? ticketTypeId;
  final String? tourId;
  final int? pricingTypeId;
  final int? minimumBookingQuantity;
  final int? maximumBookingQuantity;
  final int? minimumTicketCount;
  final int? maximumTicketCount;
  final String? fromAge;
  final String? toAge;
  final String? fromPrice;
  final String? toPrice;
  final List<PricingTicketRangeEntity>? priceRange;
  final PricingTypeEntity? pricingType;
  final TicketEntity? ticket;

  const PricingTicketEntity({
    this.ticketTypeId,
    this.tourId,
    this.pricingTypeId,
    this.minimumBookingQuantity,
    this.maximumBookingQuantity,
    this.minimumTicketCount,
    this.maximumTicketCount,
    this.fromAge,
    this.toAge,
    this.fromPrice,
    this.toPrice,
    this.priceRange,
    this.pricingType,
    this.ticket,
  });

  @override
  List<Object?> get props => [
        ticketTypeId,
        tourId,
        pricingTypeId,
        minimumBookingQuantity,
        maximumBookingQuantity,
        minimumTicketCount,
        maximumTicketCount,
        fromAge,
        toAge,
        fromPrice,
        toPrice,
        priceRange,
        pricingType,
        ticket
      ];
}
