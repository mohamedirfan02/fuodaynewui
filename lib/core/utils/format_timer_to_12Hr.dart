import 'package:intl/intl.dart';

String formatTimeTo12Hr(String time) {
  try {
    final date = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("hh:mm a").format(date); // → "09:15 AM"
  } catch (_) {
    return "00:00 AM";
  }
}
