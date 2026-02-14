import 'package:intl/intl.dart';

class DateTimeUtils {
  /// Format DateTime to string with custom pattern
  /// Example: "7th Feb 2025, 10:20 am"
  static String formatDateTime(DateTime? dateTime, {String pattern = "d'th' MMM yyyy, hh:mm a"}) {
    if (dateTime == null) return '';
    try {
      return DateFormat(pattern).format(dateTime.toLocal());
    } catch (e) {
      return dateTime.toString();
    }
  }

  /// Format DateTime to custom pattern
  /// Example: "7th Feb 2025"
  static String formatDate(DateTime? dateTime, {String pattern = "d'th' MMM yyyy"}) {
    if (dateTime == null) return '';
    try {
      return DateFormat(pattern).format(dateTime.toLocal());
    } catch (e) {
      return dateTime.toString();
    }
  }

  /// Format DateTime to time only
  /// Example: "10:20 am"
  static String formatTime(DateTime? dateTime, {String pattern = "hh:mm a"}) {
    if (dateTime == null) return '';
    try {
      return DateFormat(pattern).format(dateTime.toLocal());
    } catch (e) {
      return dateTime.toString();
    }
  }

  /// Format DateTime to "Placed at 7th Feb 2025, 10:20 am"
  static String formatPlacedAt(DateTime? dateTime) {
    if (dateTime == null) return '';
    return "Placed at ${formatDateTime(dateTime.toLocal())}";
  }

  /// Get relative time (e.g., "2 hours ago", "Today", "Yesterday")
  static String getRelativeTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes < 1) {
          return "Just now";
        }
        return "${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago";
      }
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else {
      return formatDate(dateTime.toLocal());
    }
  }

  /// Check if date is today
  static bool isToday(DateTime? dateTime) {
    if (dateTime == null) return false;
    final now = DateTime.now();
    return dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime? dateTime) {
    if (dateTime == null) return false;
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return dateTime.day == yesterday.day &&
        dateTime.month == yesterday.month &&
        dateTime.year == yesterday.year;
  }

  /// Check if date is in the past
  static bool isPast(DateTime? dateTime) {
    if (dateTime == null) return false;
    return dateTime.isBefore(DateTime.now());
  }

  /// Check if date is in the future
  static bool isFuture(DateTime? dateTime) {
    if (dateTime == null) return false;
    return dateTime.isAfter(DateTime.now());
  }

  /// Get days difference between two dates
  static int getDaysDifference(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return 0;
    return endDate.difference(startDate).inDays;
  }

  /// Get hours difference between two dates
  static int getHoursDifference(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return 0;
    return endDate.difference(startDate).inHours;
  }

  /// Format DateTime to ISO format
  static String toIsoString(DateTime? dateTime) {
    if (dateTime == null) return '';
    return dateTime.toIso8601String();
  }

  /// Parse string to DateTime
  static DateTime? parseDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Format DateTime with month name
  /// Example: "7th February 2025"
  static String formatWithFullMonth(DateTime? dateTime) {
    if (dateTime == null) return '';
    try {
      return DateFormat("d'th' MMMM yyyy").format(dateTime);
    } catch (e) {
      return dateTime.toString();
    }
  }

  /// Format DateTime as "Mon, 7 Feb 2025"
  static String formatWithDayName(DateTime? dateTime) {
    if (dateTime == null) return '';
    try {
      return DateFormat("EEE, d MMM yyyy").format(dateTime);
    } catch (e) {
      return dateTime.toString();
    }
  }

  /// Get current DateTime
  static DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  /// Add days to DateTime
  static DateTime addDays(DateTime? dateTime, int days) {
    if (dateTime == null) return DateTime.now();
    return dateTime.add(Duration(days: days));
  }

  /// Subtract days from DateTime
  static DateTime subtractDays(DateTime? dateTime, int days) {
    if (dateTime == null) return DateTime.now();
    return dateTime.subtract(Duration(days: days));
  }

  /// Convert DateTime to milliseconds since epoch
  static int toMilliseconds(DateTime? dateTime) {
    if (dateTime == null) return 0;
    return dateTime.millisecondsSinceEpoch;
  }

  /// Convert milliseconds since epoch to DateTime
  static DateTime fromMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }
}