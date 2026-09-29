import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/user_info.dart';
part 'money_reward.g.dart';

@HiveType(typeId: 43)
class MoneyReward extends QuestReward {
  @HiveField(1)
  double amount;

  MoneyReward({
    required super.id,
    required this.amount,
  });

  @override
   void give(UserInfo userInfo, String name) {
    userInfo.moneyManager.wallet.money += amount;
  }

  @override
  Widget getWidget() =>
    Text('$amount🪙');

  @override
  QuestReward get createNew => MoneyReward(id: id, amount: amount);

  @override
  double get baseValue => amount.toDouble();

  @override
  void init(double target) {
    amount = target;
  }
  @override
  int get hashCode => Object.hash(id, amount);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is MoneyReward &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amount == other.amount;
}