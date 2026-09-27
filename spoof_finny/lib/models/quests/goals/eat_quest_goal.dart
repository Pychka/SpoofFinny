import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/game_events/use_item_game_event.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import '../../game_events/eat_game_event.dart';
part 'eat_quest_goal.g.dart';

@HiveType(typeId: 32)
class EatQuestGoal extends QuestGoalProgress {
  EatQuestGoal({
    super.currentValue,
    required super.requiredValue,
    required super.title,
    required super.itemName,
    required super.timeChangedEvent
  });


  @override
  void onEvent(GameEvent action) {
    if(action is EatGameEvent && action.foodName == itemName){
      currentValue += action.count;
      return;
    }
    if(action is UseItemGameEvent && action.item.name == itemName){
      currentValue += action.count;
      return;
    }
  }
}