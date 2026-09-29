import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/money_system/term_account.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
part 'saving_account.g.dart';

@HiveType(typeId: 9)
class SavingAccount extends MoneyStorage implements TermAccount{
  @HiveField(1)
  double _debt = 0.0;
  ValueNotifier<double> debtNotifier = ValueNotifier(0.0);
  @HiveField(2)
  final double percents = 10.0;
  @HiveField(3)
  final int payingDay;

  double get debt => _debt;

  set debt(double value){
    _debt = value;
    debtNotifier.value = value;
    GameState.instance.saveUserInfo();
  }

  SavingAccount({required this.payingDay, super.money = 0.0});

  @override
  void accrueInterest(GameTimeChangedEvent event){
    GameTime time = event.from.createNew;
    for(; time.day < event.to.day || time.day - event.to.day >= 30; time.addDays(1)){
      debt += money / 100 * (percents / 365);
      if(time.day == payingDay){
        money += debt;
        debt = 0;
      }
    }
  }

  @override
  void init() {
    debtNotifier.value = debt;
    super.init();
  }
  @override
  String get billType => 'Накопительный счёт';
}