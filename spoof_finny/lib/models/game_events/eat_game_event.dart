import 'package:spoof_finny/models/game_events/time_skipped.dart';

class EatGameEvent extends TimeSkipped {
  final String foodName;
  final int count;

  EatGameEvent({
    required this.foodName,
    required this.count,
    required super.timeChangedEvent,
  });
}