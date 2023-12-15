import 'package:zest_trip/features/payment/domain/entities/tour_availability_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_availability_special_date_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_availability_weekday_entity.dart';

class TourAvailabilityModel extends TourAvailabilityEntity {
  const TourAvailabilityModel(
      {int? id,
      String? tourId,
      String? name,
      List<SpecialDate>? specialDate,
      List<Weekday>? weekdays,
      DateTime? validityDateRangeFrom,
      DateTime? validityDateRangeTo,
      String? status})
      : super(
          id: id,
          tourId: tourId,
          name: name,
          specialDates: specialDate,
          weekdays: weekdays,
          validityDateRangeFrom: validityDateRangeFrom,
          validityDateRangeTo: validityDateRangeTo,
          status: status,
        );

  factory TourAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return TourAvailabilityModel(
      id: json['id'],
      tourId: json['tourId'],
      name: json['name'],
      status: json['status'],
      specialDate: json['special_dates'] != null
          ? List<SpecialDate>.from(json['special_dates']
              .map((component) => SpecialDate.fromJson(component)))
          : [],
      weekdays: json['weekdays'] != null
          ? List<Weekday>.from(
              json['weekdays'].map((component) => Weekday.fromJson(component)))
          : [],
      validityDateRangeFrom:
          DateTime.tryParse(json['validity_date_range_from']),
      validityDateRangeTo: DateTime.tryParse(json['validity_date_range_to']),
    );
  }
}
