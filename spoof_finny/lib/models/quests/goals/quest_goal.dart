import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import 'package:spoof_finny/models/game_events/time_skipped.dart';
part 'quest_goal.g.dart';

@HiveType(typeId: 29)
class QuestGoal extends TimeSkipped{
  @HiveField(0)
  String title;  

  QuestGoal({
    required this.title,
    required super.timeChangedEvent
  });

  bool isCompleted(){
    return false;
  }

  void onEvent(GameEvent action){
  }

  Widget getWidget(){
    return Icon(isCompleted() ? Icons.check_box_outline_blank : Icons.check_box_outlined);
  }
}