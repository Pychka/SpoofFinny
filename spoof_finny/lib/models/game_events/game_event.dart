import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';

sealed class GameEvent {
  const GameEvent();
}

// getItem,
// sale,

class ChangeStatValueGameEvent extends GameEvent {
  final PlayerStat stat;
  final int value;
  final Operator operator;

  const ChangeStatValueGameEvent({
    required this.stat,
    required this.value,
    required this.operator,
  });
}

class CritStatValueGameEvent extends GameEvent {
  final String name;
  final StatValueState state;

  const CritStatValueGameEvent({
    required this.name,
    required this.state,
  });
}
  
class CompleteTaskGameEvent extends GameEvent {
  final int taskId;
  final List<QuestReward> rewards;

  const CompleteTaskGameEvent({
    required this.taskId,
    this.rewards = const []
  });
}

class BuyGameEvent extends GameEvent {
  final String itemName;
  final int count;
  final double totalPrice;

  const BuyGameEvent({
    required this.itemName,
    required this.count,
    required this.totalPrice,
  });

}

class EatGameEvent extends GameEvent {
  final String foodName;
  final int count;

  const EatGameEvent({
    required this.foodName,
    required this.count,
  });
}