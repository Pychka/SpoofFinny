import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/user_info.dart';

abstract class QuestReward {
  void give(UserInfo userInfo, String name);
  Widget getWidget();
}