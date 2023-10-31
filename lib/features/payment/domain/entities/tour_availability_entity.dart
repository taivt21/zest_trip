import 'package:equatable/equatable.dart';
import './tour_availability_weekday_entity.dart';
import './tour_availability_special_date_entity.dart';

class TourAvailabilityEntity extends Equatable {
  final int? id;
  final String? tourId;
  final String? name;
  final List<SpecialDate>? specialDates;
  final List<Weekday>? weekdays;
  final DateTime? validityDateRangeFrom;
  final DateTime? validityDateRangeTo;
  final String? status;

  const TourAvailabilityEntity({
    this.id,
    this.tourId,
    this.name,
    this.specialDates,
    this.weekdays,
    this.validityDateRangeFrom,
    this.validityDateRangeTo,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        tourId,
        name,
        specialDates,
        weekdays,
        validityDateRangeFrom,
        validityDateRangeTo,
        status,
      ];
}
