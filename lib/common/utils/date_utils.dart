class DateUtils {
  String getFormattedDate(
    DateTime dateTime,
  ) {
    final today = DateTime.now();
    final difference = dateTime.difference(today);
    return switch (difference) {
      Duration(inDays: 0) => 'today',
      Duration(inDays: 1) => 'tomorrow',
      Duration(inDays: -1) => 'yesterday',
      Duration(inDays: final days) when days > 7 =>
        '${days ~/ 7} weeks from now',
      Duration(inDays: final days) when days < -7 =>
        '${days.abs() ~/ 7} weeks ago',
      Duration(inDays: final days, isNegative: true) =>
        '${days.abs()} days ago',
      Duration(inDays: final days) => '$days days from now',
    };
  }
}
