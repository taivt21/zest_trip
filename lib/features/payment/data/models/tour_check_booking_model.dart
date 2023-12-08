import 'package:zest_trip/features/payment/data/models/pricing_ticket_model.dart';
import 'package:zest_trip/features/payment/data/models/tour_availability_model.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_check_booking_entity.dart';

class TourCheckBookingModel extends TourCheckBookingEntity {
  const TourCheckBookingModel({
    List<TourAvailabilityModel>? tourAvailability,
    List<PricingTicketModel>? pricingTicket,
  }) : super(tourAvailability: tourAvailability, pricingTicket: pricingTicket);

  factory TourCheckBookingModel.fromJson(Map<String, dynamic> json) {
    return TourCheckBookingModel(
      tourAvailability: json['availability'] != null
          ? List<TourAvailabilityModel>.from(json['availability']
              .map((component) => TourAvailabilityModel.fromJson(component)))
          : [],
      pricingTicket: json['pricing'] != null
          ? List<PricingTicketModel>.from(json['pricing']
              .map((component) => PricingTicketModel.fromJson(component)))
          : [],
    );
  }
}
