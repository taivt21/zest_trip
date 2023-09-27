import 'package:equatable/equatable.dart';

class TourTag extends Equatable {
  final int? id;
  final String? name;

  const TourTag({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  factory TourTag.fromJson(Map<String, dynamic> json) {
    return TourTag(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
