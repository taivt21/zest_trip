import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(num number) {
    return NumberFormat("#,###").format(number);
  }

  static String checkAmPm(String time) {
    int hour = int.parse(time.split(':')[0]);
    return hour < 12 ? 'AM' : 'PM';
  }
}
