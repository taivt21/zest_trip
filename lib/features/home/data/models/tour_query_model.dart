import 'package:equatable/equatable.dart';

class TourQuery extends Equatable {
  final String? search;
  final String? category;
  final int? minPrice;
  final int? maxPrice;

  const TourQuery({
    this.search,
    this.category,
    this.minPrice,
    this.maxPrice,
  });

  @override
  List<Object?> get props => [search, category, minPrice, maxPrice];

  factory TourQuery.fromJson(Map<String, dynamic> json) {
    return TourQuery(
      search: json['search'] as String,
      category: json['category'] as String,
      minPrice: json['minPrice'] as int,
      maxPrice: json['maxPrice'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'search': search,
      'category': category,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
    };
  }
}
