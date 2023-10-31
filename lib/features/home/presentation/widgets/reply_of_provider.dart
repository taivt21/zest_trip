import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class ReplyOfProvider extends StatelessWidget {
  final String avatarUrl;
  final String userName;
  final String replyText;
  final DateTime replyDateTime;

  const ReplyOfProvider({
    Key? key,
    required this.avatarUrl,
    required this.userName,
    required this.replyText,
    required this.replyDateTime,
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
          // Row(
          //   children: [
          //     CircleAvatar(
          //       backgroundImage: NetworkImage(avatarUrl),
          //       radius: 16.0,
          //     ),
          //     const SizedBox(width: 8.0),
          //     Text(
          //       userName,
          //       style: const TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 14.0,
          //       ),
          //     ),
          //   ],
          // ),
          Text(
            "Reply of Provider",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4.0),
          Text(
            replyText,
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
    return "${replyDateTime.day}/${replyDateTime.month}/${replyDateTime.year}";
  }
}
