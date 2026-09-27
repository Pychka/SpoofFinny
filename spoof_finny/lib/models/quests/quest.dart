import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/game_events/time_skipped.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/quest_state.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';

part 'quest.g.dart';

@HiveType(typeId: 11)
class Quest extends TimeSkipped {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  QuestState state;
  @HiveField(30)
  List<QuestReward> rewards;
  @HiveField(4)
  List<QuestGoal> goals;
  @HiveField(5)
  int id;
  int _completedGoals = 0;
  Quest({
    required this.id,
    required this.title,
    required this.description,
    this.rewards = const [],
    this.goals = const [],
    this.state = QuestState.active,
    required super.timeChangedEvent
  }){
    completedGoals = goals.where((questGoal) => questGoal.isCompleted()).length;
  }

  void onEvent(GameEvent gameEvent){
    if(state != QuestState.active) return;

    int currentCompletedGoals = _completedGoals;
    int completedGoals = 0;
    for(final goal in goals){
      goal.onEvent(gameEvent);
      if(goal.isCompleted()){
        completedGoals++;
      }
    }
    
    if(currentCompletedGoals != completedGoals){
      GameState.instance.saveUserInfo();
    }

    GameState.instance.saveUserInfo();
    if(completedGoals == goals.length){
      state = QuestState.completed;
    }
  }

  bool isCompleted() => goals.every((goal) => goal.isCompleted());

  ValueNotifier<int> completedGoalsNotifier = ValueNotifier(0);

  int get completedGoals => _completedGoals;

  set completedGoals(int completed){
    _completedGoals = completed;
    completedGoalsNotifier.value = completed;
  }
}