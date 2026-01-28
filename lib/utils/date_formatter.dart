import 'package:intl/intl.dart';

class DateFormatter {
  static String toRelativeTime(DateTime? dateTime) {
    if (dateTime == null) return "N/A";

    final now = DateTime.now();
    final localTime = dateTime.toLocal();
    final difference = now.difference(localTime);

    if (difference.inSeconds < 60) {
      return "Vừa xong";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} phút trước";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} giờ trước";
    } else {
      return DateFormat('dd-MM-yyyy').format(localTime);
    }
  }

  static String toVietnamese(DateTime? dateTime) {
    if (dateTime == null) return "N/A";
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime.toLocal());
  }
}