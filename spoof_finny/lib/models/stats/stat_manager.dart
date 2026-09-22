
import 'dart:async';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/quests/rewards/stat_reward.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';

part 'stat_manager.g.dart';

@HiveType(typeId: 15)
class StatManager {
  @HiveField(0)
  Map<String, PlayerStat> stats;
  GameEventBus? actionBus;
  late StreamSubscription onActionHappenSubscription;

  StatManager({
    required this.stats,
    this.actionBus,
  });

  void init(){
    onActionHappenSubscription = actionBus!.onActionHappen.listen((gameEvent) {
      if(gameEvent is CompleteTaskGameEvent){
        for(final reward in gameEvent.rewards.whereType<StatReward>()){
          _changeStat(stats[reward.statName], reward.amount, reward.operator);
        }
      }
      if(gameEvent is ChangeStatValueGameEvent){
        _changeStat(gameEvent.stat, gameEvent.value, gameEvent.operator);
      }
    });
  }

  void dispose() {
    onActionHappenSubscription.cancel();
  }

  void updateStat(String statName, int value, Operator operator){
    final stat = stats[statName];
    if(stat == null){
      return;
    }
    actionBus!.actionHappen(ChangeStatValueGameEvent(stat: stat, value: value, operator: operator));
  }

  void addStat(PlayerStat stat){
    stats[stat.name] = stat;
  }

  void _changeStat(PlayerStat? stat, int value, Operator operator){
    if(stat == null) return;
    
    switch(operator){
      case Operator.change:
        stat.currentValue = value;
      case Operator.multi:
        stat.currentValue *= value;
      case Operator.minus:
        stat.currentValue -= value;
      case Operator.plus:
        stat.currentValue += value;
      case Operator.divide:
        stat.currentValue = (stat.currentValue / value).toInt();
    }
    final state = stat.state();
    if(state == StatValueState.normal) return;
    actionBus!.actionHappen(CritStatValueGameEvent(name: stat.name, state: state));
  }
}