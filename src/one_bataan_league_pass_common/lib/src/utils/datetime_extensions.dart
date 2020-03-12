extension DateTimeExtensions on DateTime {
  /// Compares this [DateTime] to [other] using the month, day, and year component.
  bool isOnTheSameDay(DateTime other) {
    final newDate = DateTime(this.year, this.month, this.day);
    final newDateToCompare = DateTime(other.year, other.month, other.day);

    return newDate.difference(newDateToCompare).inDays == 0;
  }
}
