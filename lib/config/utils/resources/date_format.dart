class DateTimeHelper {
  static String joinedAgo(DateTime createdAt) {
    final DateTime now = DateTime.now();

    final int months =
        (now.year - createdAt.year) * 12 + now.month - createdAt.month;

    if (months == 0) {
      final int days = now.difference(createdAt).inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else {
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }
}
