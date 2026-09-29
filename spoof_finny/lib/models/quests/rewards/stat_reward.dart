import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/user_info.dart';

class StatReward extends QuestReward {
  int amount;
  PlayerStat stat;
  Operator operator;

  StatReward({
    required super.id,
    required this.amount,
    required this.stat,
    required this.operator,
  });

  @override
   void give(UserInfo userInfo, String name) {
    userInfo.statManager.updateStat(stat, amount, operator);
  }

  @override
  Widget getWidget() =>
    Text('${operatorToString()}$amount ${stat.icon}');

  String operatorToString(){
    switch(operator){
      case Operator.change:
        return '=';
      case Operator.multi:
        return 'x';
      case Operator.minus:
        return '-';
      case Operator.plus:
        return '+';
      case Operator.divide:
        return '/';
    }
  }
  @override
  void init(double target) {
    amount = target.toInt();
    stat = GameState.instance.userInfo.statManager.getRandomStat();
  }

  @override
  double get baseValue => amount.toDouble();

  @override
  QuestReward get createNew => StatReward(id: id, amount: amount, stat: stat, operator: operator);

  @override
  int get hashCode => Object.hash(id, stat);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is StatReward &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          stat == other.stat;
}