import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/game_time_changed_event.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';

part 'credit_card.g.dart';

@HiveType(typeId: 5)
class CreditCard extends MoneyStorage{
  @HiveField(1)
  double _debt = 0.0;
  ValueNotifier<double> debtNotifier = ValueNotifier(0.0);
  @HiveField(2)
  final double limit = 20000.0;
  @HiveField(3)
  final double dailyInterestRate = 10.0;
  final DateTime lastPayDate =  DateTime.fromMicrosecondsSinceEpoch(0).add(Duration(days: 100000000));

  CreditCard({super.money = 0.0});

  double get debt => _debt;

  set debt(double value){
    _debt = value;
    debtNotifier.value = value;
    GameState.instance.saveUserInfo();
  }

  void accrueInterest(GameTimeChangedEvent event){
    if(event.isLess(lastPayDate, event.to) && lastPayDate.difference(event.to).inDays / 30 > 0){
      debt += (debt + (money < 0 ? money * -1 : 0)) * (lastPayDate.difference(event.to).inDays / 30);
    }
  }

  @override
  bool get(double needable) {
    if(money >= needable && needable > limit * -1){
      money -= needable;
      return true;
    }
    return false;
  }

  void put(double money){
    if(debt != 0){
      debt -= money;
      if(debt < 0){
        super.money -= debt;
        debt = 0;
      }
    }
    super.money += money;
  }

  @override
  void init() {
    debtNotifier.value = debt;
    super.init();
  }
}