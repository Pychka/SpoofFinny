import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/user_info.dart';
part 'experience_reward.g.dart';

@HiveType(typeId: 45)
class ExperienceReward extends QuestReward {
  @HiveField(1)
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