import 'package:intl/intl.dart';

class DateUtil {
  DateUtil._();

  static String formatDate(dynamic date, {String format = "yyyy-MM-dd"}) {
    if (date == null || date == 0 || date == "0") {
      return "";
    }
    if (![String, DateTime].contains(date.runtimeType)) {
      throw Exception("Not Allowed Type of date : $date");
    }
    return date.runtimeType == String
        ? DateFormat(format).format(DateTime.parse(date as String))
        : DateFormat(format).format(date as DateTime);
  }

  static String beforeDate(dynamic date) {
    return "${DateTime.now().difference(DateTime.parse(date as String)).inDays.toString()}일전";
  }
}
