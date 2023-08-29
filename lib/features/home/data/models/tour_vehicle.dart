// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TourVehicle extends Equatable {
  final int? id;
  final String? name;

  const TourVehicle({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];

  factory TourVehicle.fromJson(Map<String, dynamic> json) {
    return TourVehicle(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
