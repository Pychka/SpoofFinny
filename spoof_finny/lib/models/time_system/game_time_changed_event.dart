import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
part 'game_time_changed_event.g.dart';

@HiveType(typeId: 33)
class GameTimeChangedEvent extends GameEvent {
  @HiveField(0)
  final GameTime from;
  @HiveField(1)
  final GameTime to;

  GameTimeChangedEvent({
    required this.from,
    required this.to
  });

  int get daysPassed => to.day - from.day;
}