import 'package:equatable/equatable.dart';

class Weekday extends Equatable {
  final int? day;
  final String? timeSlot;

  const Weekday({
    this.day,
    this.timeSlot,
  });

  @override
  List<Object?> get props => [day, timeSlot];

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(
      day: json['day'],
      timeSlot: json['timeSlot'],
    );
  }
}
