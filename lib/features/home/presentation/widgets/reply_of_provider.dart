// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/domain/entities/provider_reply_entity.dart';

class ReplyOfProvider extends StatelessWidget {
  final ProviderReplyEntity providerReplyEntity;

  const ReplyOfProvider({
    Key? key,
    required this.providerReplyEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: const BoxDecoration(color: colorBackground),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reply of Provider",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4.0),
          Text(
            providerReplyEntity.content!,
            style: const TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            _getFormattedDate(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    return "${providerReplyEntity.createdAt!.day}/${providerReplyEntity.createdAt!.month}/${providerReplyEntity.createdAt!.year}";
  }
}
