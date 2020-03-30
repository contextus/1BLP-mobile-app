/// Extension methods for `DateTime`.
extension DateTimeExtensions on DateTime {
  /// Identify whether this [DateTime] is on the same day as the [other].
  ///
  /// Compares this [DateTime] to [other] using the month, day, and year component.
  ///
  /// Example:
  ///
  /// ```dart
  /// final dateToday = DateTime(1980, 1, 1);
  /// final isToday = dateToday.isOnTheSameDay(DateTime(1980, 1, 1));
  ///
  /// // Prints true
  /// print(isToday);
  /// ```
  bool isOnTheSameDay(DateTime other) {
    final newDate = DateTime(this.year, this.month, this.day);
    final newDateToCompare = DateTime(other.year, other.month, other.day);

    return newDate.difference(newDateToCompare).inDays == 0;
  }
}
