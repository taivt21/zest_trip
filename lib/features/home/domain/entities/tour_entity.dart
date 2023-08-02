import 'package:equatable/equatable.dart';

class TourEntity extends Equatable {
  final String? id;
  final String? userIdProvider;
  final String? tourDescription;
  final String? tourHighlights;
  final String? tourFootnote;
  final String? tourComponents;
  final String? duration;
  final String? location;
  final String? tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;

  const TourEntity({
    this.id,
    this.userIdProvider,
    this.tourDescription,
    this.tourHighlights,
    this.tourFootnote,
    this.tourComponents,
    this.duration,
    this.location,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  @override
  List<Object?> get props {
    return [
      id,
      userIdProvider,
      tourDescription,
      tourHighlights,
      tourFootnote,
      tourComponents,
      duration,
      location,
      tags,
      createdAt,
      updatedAt,
      status,
    ];
  }
}
