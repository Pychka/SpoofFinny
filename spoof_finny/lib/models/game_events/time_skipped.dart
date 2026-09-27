import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
part 'time_skipped.g.dart';

@HiveType(typeId: 29)
class TimeSkipped extends GameEvent{
  @HiveField(99)
  GameTimeChangedEvent timeChangedEvent;
  TimeSkipped({required this.timeChangedEvent});

  void onUse(){
    GameState.instance.gameEventBus.actionHappen(timeChangedEvent);
  }
}