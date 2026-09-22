import 'package:flutter/foundation.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';

enum StatType{
  constant,
  temporary
}

class PlayerStat {
  String name;
  final StatType type;
  int _currentValue;
  int maxValue;
  int minValue;
  int? critMinValue;
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