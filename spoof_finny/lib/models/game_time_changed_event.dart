class GameTimeChangedEvent {
  final DateTime from;
  final DateTime to;

  GameTimeChangedEvent({
    required this.from,
    required this.to
  });

  int get daysPassed => to.difference(from).inDays;

  bool isLess(DateTime left, DateTime right) =>
    left.microsecond < right.microsecond && left.second < right.second && left.minute < right.minute && left.hour < right.hour && left.day < right.day && left.month < right.month && left.year < right.year;
}