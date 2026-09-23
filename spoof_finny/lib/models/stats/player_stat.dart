import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/stats/stat_type.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';

part 'player_stat.g.dart';

@HiveType(typeId: 16)
class PlayerStat {
  @HiveField(0)
  String name;
  @HiveField(1)
  final StatType type;
  @HiveField(2)
  int _currentValue;
  @HiveField(3)
  int maxValue;
  @HiveField(4)
  int minValue;
  @HiveField(5)
  int? critMinValue;
  @HiveField(6)
  int? critMaxValue;
  ValueNotifier<int> currentValueNotifier = ValueNotifier(0);

  PlayerStat({
    required this.name,
    required this.type,
    int currentValue = 0,
    this.maxValue = 100,
    this.minValue = -100,
    this.critMinValue = -50,
    this.critMaxValue,
  }) : _currentValue = currentValue {
    currentValueNotifier.value = currentValue;
  }

  int get currentValue => _currentValue;

  set currentValue(int value){
    _currentValue = value;
    currentValueNotifier.value = value;
  }

  StatValueState state(){
    if(critMinValue != null && currentValue <= critMinValue!){
      return StatValueState.critMin;
    }
    if(critMaxValue != null && currentValue >= critMaxValue!){
      return StatValueState.critMin;
    }
    return StatValueState.normal;
  }
}