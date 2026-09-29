import 'dart:math';
import 'package:collection/collection.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/game_events/use_item_game_event.dart';
import 'package:spoof_finny/models/items/food.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
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
    required super.timeChangedEvent, required super.id
  });

  @override
  void setTarget(double value){
    final item = ItemFactory.instance.getRandomItem<Food>();
    itemName = item.name;
    requiredValue = min((30 / max(1, (item.events.firstWhereOrNull((event) => event.stat.name == 'hygiene')?.value ?? 1))).toInt(), value.toInt());
  }

  @override
  double get baseValue => requiredValue.toDouble();

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
 
  @override
  int get hashCode => Object.hash(id, requiredValue, itemName);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is EatQuestGoal &&
        itemName == other.itemName &&
        requiredValue == other.requiredValue &&
        id == other.id;
  
  @override
  QuestGoal get createNew => EatQuestGoal(requiredValue: requiredValue, title: title, itemName: itemName, timeChangedEvent: timeChangedEvent, id: id);
}