import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/game_events/use_item_game_event.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';

import '../../game_events/eat_game_event.dart';

class EatQuestGoal extends QuestGoalProgress {
  EatQuestGoal({
    required super.currentValue,
    required super.requiredValue,
    required super.title,
    required super.itemName
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