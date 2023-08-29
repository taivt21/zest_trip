import 'package:equatable/equatable.dart';

class TourTag extends Equatable {
  final int? id;
  final String? name;
  final int? type;

  const TourTag({
    this.id,
    this.name,
    this.type,
  });

  @override
  List<Object?> get props => [id, name, type];

  factory TourTag.fromJson(Map<String, dynamic> json) {
    return TourTag(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      type: json['type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}
