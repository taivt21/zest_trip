import 'package:zest_trip/features/payment/domain/entities/ticket_entity.dart';

class TicketModel extends TicketEntity {
  const TicketModel({
    int? id,
    String? name,
  }) : super(id: id, name: name);

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(id: json["id"], name: json["name"]);
  }
}
