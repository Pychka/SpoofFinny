import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/user_info.dart';

class ExperienceReward extends QuestReward {
  int amount;

  ExperienceReward({
    required super.id,
    required this.amount,
  });

  @override
   void give(UserInfo userInfo, String name) {
    userInfo.experienceSystem.addExperience(amount);
  }

  @override
  Widget getWidget() =>
    Text('$amount ОП');

  @override
  void init(double target) {
    amount = target.toInt();
  }

  @override
  double get baseValue => amount.toDouble();

  @override
  QuestReward get createNew => ExperienceReward(id: id, amount: amount);

  @override
  int get hashCode => Object.hash(id, amount);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is ExperienceReward &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amount == other.amount;
}