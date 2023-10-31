// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String tourId;
  final String tourName;
  final int adult;
  final int? children;
  final int totalPrice;
  final DateTime selectedDate;
  final DateTime returnDate;
  final String timeSlot;

  const OrderEntity({
    required this.tourId,
    required this.tourName,
    required this.adult,
    required this.children ,
    required this.totalPrice,
    required this.selectedDate,
    required this.returnDate,
    required this.timeSlot,
  });

  @override
  List<Object?> get props => [
        tourId,
        tourName,
        adult,
        children,
        totalPrice,
        selectedDate,
        returnDate,
        timeSlot
      ];
}
