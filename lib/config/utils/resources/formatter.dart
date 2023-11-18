import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(num number) {
    
    return NumberFormat("#,###").format(number);
  }
}
