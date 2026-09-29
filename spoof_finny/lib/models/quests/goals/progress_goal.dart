import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
part 'progress_goal.g.dart';

@HiveType(typeId: 31)
class ProgressGoal extends QuestGoal {
  @HiveField(2)
  QuestGoalProgress progress;

  ProgressGoal({
    required this.progress,
    required super.title,
    required super.timeChangedEvent,
    required super.id,
  });

  @override
  bool isCompleted() =>
    progress.isCompleted();

  @override
  double get baseValue => progress.requiredValue.toDouble();

  
  @override
  QuestGoal get createNew => ProgressGoal(id: id, timeChangedEvent: timeChangedEvent, title: title, progress: progress);
  
  @override
  int get hashCode => Object.hash(id, progress);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is ProgressGoal &&
          progress == other.progress &&
          id == other.id;
}