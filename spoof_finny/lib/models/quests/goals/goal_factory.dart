import 'dart:math';
import 'package:spoof_finny/models/quests/goals/buy_quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/eat_quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/exp_quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/money_quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';

class GoalFactory {
  final Map<String, QuestGoal> _factories = {};
  static final Random random = Random();
  GoalFactory._internal();

  List<QuestGoal> get goals => List.unmodifiable(_factories.values);

  QuestGoal getRandomTypedQuestGoal<T extends QuestGoal>(){
    final goals = _factories.values.whereType<T>().toList();
    return goals[random.nextInt(goals.length)].createNew;
  }

  QuestGoal getRandomQuestGoal() =>
    goals[random.nextInt(goals.length)].createNew;

  static final GoalFactory instance = GoalFactory._internal();

  List<QuestGoal> get getGoals => List.unmodifiable(_factories.values);

  QuestGoal get(String name, int count){
    final quest = _factories[name];

    if (quest == null) {
      throw Exception("Not found factory by key: $name");
    }

    return quest.createNew;
  }

  void register(QuestGoal item) =>
    _factories[item.id] = item;

  void init(){
    register(
      EatQuestGoal(
        id: 'eat',
        currentValue: 0,
        requiredValue: 2,
        title: 'Съешь {requiredValue} {itemName}',
        itemName: '',
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 20)
        )
      )
    );
    register(
      BuyQuestGoal(
        requiredTotalPrice: 20,
        requiredValue: 0,
        title: 'Купи {itemName} на сумму {requiredValue}',
        itemName: '',
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 20)
        ),
        id: 'buy'
      )
    );
    register(
      MoneyQuestGoal(
        requiredTotalValue: 10,
        requiredValue: 20,
        title: 'Заработай {requiredValue} монеток',
        itemName: '',
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 20)
        ),
        id: 'accumulate_money'
      )
    );
    register(
      ExpQuestGoal(
        requiredTotalValue: 10,
        requiredValue: 20,
        title: 'Получи {requiredValue} опыта',
        itemName: '',
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 20)
        ),
        id: 'accumulate_exp'
      )
    );
    
  }
}