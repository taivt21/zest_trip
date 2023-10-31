import 'package:equatable/equatable.dart';

class PricingTypeEntity extends Equatable {
  final int? id;
  final String? name;

  const PricingTypeEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
