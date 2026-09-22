import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/user_info.dart';

class ExperienceReward extends QuestReward {
  final int amount;

  ExperienceReward({
    required this.amount,
  });

  @override
   void give(UserInfo userInfo, String name) {
    userInfo.experienceSystem.addExperience(amount);
  }

  @override
  Widget getWidget() =>
    Text('$amount ОП');
}