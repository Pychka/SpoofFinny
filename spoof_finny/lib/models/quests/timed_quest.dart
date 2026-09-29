import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
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
  
  @HiveField(8)
  GameTime startAt;

  TimedQuest({
    required this.endAt,
    required this.startAt,
    required super.title,
    required super.description,
    required super.id,
    super.rewards,
    super.goals,
    super.state,
    required super.timeChangedEvent
  });

  @override
  void onEvent(GameEvent gameEvent) {
    if(state != QuestState.active) return;
    if(endAt.totalSeconds < GameState.instance.userInfo.timeManager.currentGameTime.totalSeconds){
      state = QuestState.expired;
      GameState.instance.saveUserInfo();
      return;
    }

    int currentCompletedGoals = super.completedGoals;
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

  static TimedQuest createByQuest(Quest quest, GameTime startAt, GameTime endAt) => TimedQuest(
    startAt: startAt,
    endAt: endAt,
    title: quest.title,
    description: quest.description,
    id: quest.id,
    state: quest.state,
    rewards: quest.rewards,
    goals: quest.goals,
    timeChangedEvent: quest.timeChangedEvent
  );
}