import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/user_info.dart';

abstract class QuestReward {
  String id;
  QuestReward({required this.id});
  void give(UserInfo userInfo, String name);
  Widget getWidget();
  QuestReward get createNew;
  void init(double target);
  double get baseValue;
}