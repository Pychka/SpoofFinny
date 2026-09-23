import 'package:spoof_finny/models/game_events/game_event.dart';

class EatGameEvent extends GameEvent {
  final String foodName;
  final int count;

  const EatGameEvent({
    required this.foodName,
    required this.count,
  });
}