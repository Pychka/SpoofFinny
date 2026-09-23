import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_state.dart';

part 'money_storage.g.dart';

@HiveType(typeId: 4)
class MoneyStorage{
  @HiveField(0)
  double moneyValue;
  final ValueNotifier<double> moneyNotifier = ValueNotifier(0.0);
  MoneyStorage({double money = 0.0}) : moneyValue = money;

  void init(){
    moneyNotifier.value = moneyValue;
  }

  double get money => moneyValue;
  set money(double money){
    moneyValue = money;
    moneyNotifier.value = money;
    GameState.instance.saveUserInfo();
  }

  bool get(double needable){
    if(money >= needable){
      money -= needable;
      return true;
    }
    return false;
  }
}