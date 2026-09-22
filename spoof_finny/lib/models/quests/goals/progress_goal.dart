import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';

class ProgressGoal extends QuestGoal {
  QuestGoalProgress progress;

  ProgressGoal({
    required this.progress,
    required super.title,
  });

  @override
  bool isCompleted() =>
    progress.isCompleted();
}