
import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/user_info.dart';

class MoneyReward extends QuestReward {
  final double amount;

  MoneyReward({
    required this.amount,
  });

  @override
   void give(UserInfo userInfo, String name) {
    userInfo.moneyManager.wallet.money += amount;
  }

  @override
  Widget getWidget() =>
    Text('$amount 🪙');
}