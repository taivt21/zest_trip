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
  final List<PricingTicketRangeEntity>? priceRange;
  final PricingTypeEntity? pricingType;
  final TicketEntity? ticket;

  const PricingTicketEntity({
    this.ticketTypeId,
    this.tourId,
    this.pricingTypeId,
    this.minimumBookingQuantity,
    this.maximumBookingQuantity,
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
        priceRange,
        pricingType,
        ticket
      ];
}
