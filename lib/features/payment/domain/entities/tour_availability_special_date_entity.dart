import 'package:equatable/equatable.dart';

class SpecialDate extends Equatable {
  final DateTime? date;
  final String? timeSlot;

  const SpecialDate({
    this.date,
    this.timeSlot,
  });

  @override
  List<Object?> get props => [date, timeSlot];

  factory SpecialDate.fromJson(Map<String, dynamic> json) {
    // String? rawDate = json['date'];

    // DateTime? parsedDate = rawDate != null ? DateTime.tryParse(rawDate) : null;

    return SpecialDate(
      date: DateTime.tryParse(json['date'])?.toUtc(),
      timeSlot: json['timeSlot'],
    );
  }
}
