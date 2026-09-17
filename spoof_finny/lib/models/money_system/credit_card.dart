import 'package:spoof_finny/models/game_time_changed_event.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';

class CreditCard extends MoneyStorage{
  double debt = 0.0;
  double _money = 0.0;
  double _limit = 20_000.0;
  final double dailyInterestRate = 10.0;
  final DateTime lastPayDate =  DateTime.fromMicrosecondsSinceEpoch(0).add(Duration(days: 100000000));

  void accrueInterest(GameTimeChangedEvent event){
    if(event.isLess(lastPayDate, event.to) && lastPayDate.difference(event.to).inDays / 30 > 0){
      debt += (debt + (_money < 0 ? _money * -1 : 0)) * (lastPayDate.difference(event.to).inDays / 30);
    }
  }

  @override
  bool get(double needable) {
    if(_money >= needable && needable > _limit * -1){
      _money -= needable;
      return true;
    }
    return false;
  }

  void put(double money){
    if(debt != 0){
      debt -= money;
      if(debt < 0){
        money -= debt;
        debt = 0;
      }
    }
    money += money;
  }
}