import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/user_info.dart';

class ItemReward extends QuestReward {
  final int count;

  ItemReward({
    required this.count,
  });

  @override
  void give(UserInfo userInfo, String name){
    userInfo.inventory.addItem(name, count);
  }
  
  @override
  Widget getWidget() =>
    Text('$count');

}