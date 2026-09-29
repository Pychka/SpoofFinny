import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/user_info.dart';
part 'quest_reward.g.dart';

@HiveType(typeId: 41)
class QuestReward {
  @HiveField(0)
  String id;
  QuestReward({required this.id});
  void give(UserInfo userInfo, String name) {}
  Widget getWidget() => throw Exception();
  QuestReward get createNew  => throw Exception();
  void init(double target) {}
  double get baseValue => 0.0;
}