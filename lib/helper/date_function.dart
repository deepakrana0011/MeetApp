import 'package:intl/intl.dart';

class DateFunctions{
  static String dateFormatddmmmmyyy(DateTime now) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);

    return formattedDate;
  }

}