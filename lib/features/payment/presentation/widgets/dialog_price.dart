import 'package:flutter/material.dart';
import 'package:zest_trip/features/payment/domain/entities/pricing_ticket_entity.dart';

class TicketPricingDialog extends StatelessWidget {
  final PricingTicketEntity ticketPricing;

  const TicketPricingDialog({Key? key, required this.ticketPricing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ticket Pricing Information'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var range in ticketPricing.priceRange!)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('From Amount: ${range.fromAmount}'),
                Text('To Amount: ${range.toAmount}'),
                Text('Price: ${range.price}'),
                const Divider(),
              ],
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
