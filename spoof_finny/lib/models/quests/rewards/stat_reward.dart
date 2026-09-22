import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/user_info.dart';

class StatReward extends QuestReward {
  final int amount;
  final String statName;
  final Operator operator;

  StatReward({
    required this.amount,
    required this.statName,
    required this.operator,
  });

  @override
   void give(UserInfo userInfo, String name) {
    userInfo.statManager.updateStat(statName, amount, operator);
  }

  @override
  Widget getWidget() =>
    Text('$amount $operatorToString $statName');

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
}