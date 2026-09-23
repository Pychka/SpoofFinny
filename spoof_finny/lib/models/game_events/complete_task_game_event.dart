import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';

class CompleteTaskGameEvent extends GameEvent {
  final int taskId;
  final List<QuestReward> rewards;

  const CompleteTaskGameEvent({
    required this.taskId,
    this.rewards = const []
  });
}
