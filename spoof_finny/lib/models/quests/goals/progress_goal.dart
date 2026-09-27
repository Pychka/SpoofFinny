import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
part 'progress_goal.g.dart';

@HiveType(typeId: 31)
class ProgressGoal extends QuestGoal {
  @HiveField(1)
  QuestGoalProgress progress;

  ProgressGoal({
    required this.progress,
    required super.title,
    required super.timeChangedEvent,
  });

  @override
  bool isCompleted() =>
    progress.isCompleted();
}