import 'package:equatable/equatable.dart';

class TicketEntity extends Equatable {
  final int? id;
  final String? name;

  const TicketEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
