import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/quests/quest.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/quest_state.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
part 'timed_quest.g.dart';

@HiveType(typeId: 32)
class TimedQuest extends Quest {
  
  @HiveField(7)
  GameTime endAt;

  TimedQuest({
    required this.endAt,
    required super.title,
    required super.description,
    required super.id,
    super.state,
    required super.timeChangedEvent
  });

  @override
  void onEvent(GameEvent gameEvent) {
    
  }
}