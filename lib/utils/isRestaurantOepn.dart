bool isRestaurantOpen({
  required String startTime,
  required String endTime,
  String? weeklyOffDay,
}) {
  final now = DateTime.now();

  // Weekly off check (optional)
  if (weeklyOffDay != null) {
    final today = _weekdayName(now.weekday);
    if (today.toLowerCase() == weeklyOffDay.toLowerCase()) {
      return false;
    }
  }

  final start = _parseTime(startTime, now);
  var end = _parseTime(endTime, now);

  // Handle overnight timing (end <= start)
  if (end.isBefore(start) || end.isAtSameMomentAs(start)) {
    end = end.add(const Duration(days: 1));
  }

  // If current time is after midnight but before end
  final adjustedNow =
  now.isBefore(start) ? now.add(const Duration(days: 1)) : now;

  return adjustedNow.isAfter(start) && adjustedNow.isBefore(end);
}


String _weekdayName(int weekday) {
  const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  return days[weekday - 1];
}

DateTime _parseTime(String time, DateTime now) {
  final parts = time.split(':');
  return DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(parts[0]),
    int.parse(parts[1]),
  );
}
