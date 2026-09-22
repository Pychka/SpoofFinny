import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'money_storage.g.dart';

@HiveType(typeId: 4)
class MoneyStorage{
  @HiveField(0)
  double _money;
  ValueNotifier<double> moneyNotifier = ValueNotifier(0.0);
  MoneyStorage({double money = 0.0}) : _money = money{
    moneyNotifier.value = _money;
  }

  double get money => _money;
  set money(double money){
    _money = money;
    moneyNotifier.value = money;
  }

  bool get(double needable){
    if(money >= needable){
      money -= needable;
      return true;
    }
    return false;
  }
}