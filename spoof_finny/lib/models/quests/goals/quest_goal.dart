import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';

class QuestGoal{
  String title;  

  QuestGoal({
    required this.title
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