// return todays date formatted as yyyymmdd
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String todaysDateFormatted() {
  // today
  var dateTimeObject = DateTime.now();

  // year in the format yyyy
  String year = dateTimeObject.year.toString();

  // month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

// convert string yyyymmdd to DateTime object
DateTime createDateTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

// convert DateTime object to string yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  // year in the format yyyy
  String year = dateTime.year.toString();

  // month in the format mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in the format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

String getMonthName(int month) {
  DateFormat dateFormat =
      DateFormat.MMMM(); // MMMM represents the full month name
  DateTime date = DateTime(
    2000,
    month,
  ); // Assuming a constant year (e.g., 2000)
  return dateFormat.format(date);
}

String appDateFormat(DateTime date) {
  String pattern = 'yyyy-MM-dd';
  var format = DateFormat(pattern, "en");
  var dateString = format.format(date);
  return dateString;
}

String appTimeFormat(DateTime time) {
  String pattern = 'HH:mm';
  var format = DateFormat(pattern, "en");
  var timeString = format.format(time);
  return timeString;
}

String timeUntil(DateTime date) {
  return timeago.format(date, allowFromNow: true);
}
