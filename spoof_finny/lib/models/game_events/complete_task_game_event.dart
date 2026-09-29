import 'package:spoof_finny/models/quests/quest_state.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/game_events/time_skipped.dart';

class CompleteTaskGameEvent extends TimeSkipped {
  final String taskId;
  final QuestState state;
  final List<QuestReward> rewards;

  CompleteTaskGameEvent({
    required this.taskId,
    required this.state,
    this.rewards = const [],
    required super.timeChangedEvent
  });
}
