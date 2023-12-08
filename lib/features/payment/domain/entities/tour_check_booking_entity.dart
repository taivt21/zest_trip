import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_availability_entity.dart';

class TourCheckBookingEntity extends Equatable {
  final List<TourAvailabilityEntity>? tourAvailability;
  final List<PricingTicketEntity>? pricingTicket;

  const TourCheckBookingEntity({
    this.tourAvailability,
    this.pricingTicket,
  });

  @override
  List<Object?> get props => [tourAvailability, pricingTicket];
}
