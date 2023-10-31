import 'package:equatable/equatable.dart';

class PricingTicketRangeEntity extends Equatable {
  final int? price;
  final int? toAmount;
  final int? fromAmount;

  const PricingTicketRangeEntity({
    this.price,
    this.toAmount,
    this.fromAmount,
  });

  @override
  List<Object?> get props => [price, toAmount, fromAmount];
}
