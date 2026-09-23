import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
part 'change_stat_value_game_event.g.dart';

@HiveType(typeId: 22)
class ChangeStatValueGameEvent extends GameEvent {
  @HiveField(0)
  final PlayerStat stat;
  @HiveField(1)
  final int value;
  @HiveField(2)
  final Operator operator;

  const ChangeStatValueGameEvent({
    required this.stat,
    required this.value,
    required this.operator,
  });

  Widget getWidget() =>
    Text('${operatorToString()} $value ${stat.name}');
  
  String operatorToString(){
    switch(operator){
      case Operator.change:
        return '=';
      case Operator.multi:
        return 'x';
      case Operator.minus:
        return '-';
      case Operator.plus:
        return '+';
      case Operator.divide:
        return '/';
    }
  }
}
