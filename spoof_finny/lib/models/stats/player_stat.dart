import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/stats/stat_type.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';

part 'player_stat.g.dart';

@HiveType(typeId: 16)
class PlayerStat {
  @HiveField(0)
  String displayedName;
  @HiveField(1)
  String name;
  @HiveField(2)
  final StatType type;
  @HiveField(3)
  int _currentValue;
  @HiveField(4)
  int maxValue;
  @HiveField(5)
  int minValue;
  @HiveField(6)
  int? critMinValue;
  @HiveField(7)
  int? critMaxValue;
  @HiveField(8)
  String icon;
  ValueNotifier<int> currentValueNotifier = ValueNotifier(0);

  PlayerStat({
    required this.displayedName,
    required this.name,
    required this.icon,
    required this.type,
    int currentValue = 0,
    this.maxValue = 100,
    this.minValue = -100,
    this.critMinValue = -100,
    this.critMaxValue,
  }) : _currentValue = currentValue {
    currentValueNotifier.value = currentValue;
  }

  int get currentValue => _currentValue;

  set currentValue(int value){
    value = value.clamp(minValue, maxValue);
    _currentValue = value;
    currentValueNotifier.value = value;
  }

  bool get hasStat => state() == StatValueState.critMax;

  StatValueState state(){
    if(critMinValue != null && currentValue <= critMinValue!){
      return StatValueState.critMin;
    }
    if(critMaxValue != null && currentValue >= critMaxValue!){
      return StatValueState.critMax;
    }
    return StatValueState.normal;
  }
}