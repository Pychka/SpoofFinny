import 'package:hive/hive.dart';
import 'package:spoof_finny/models/game_time_changed_event.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
part 'saving_account.g.dart';

@HiveType(typeId: 9)
class SavingAccount extends MoneyStorage{
  @HiveField(1)
  double debt = 0.0;
  @HiveField(2)
  final double percents = 10.0;
  @HiveField(3)
  final int payingDay;

  SavingAccount({required this.payingDay, required super.money});

  void accrueInterest(GameTimeChangedEvent event){
    DateTime dateTime = event.from;
    for(; dateTime.day < event.to.day || dateTime.month < event.to.month; dateTime.add(Duration(days: 1))){
      debt += money / 100 * (percents / event.from.year % 4 == 0 ? 366 : 365);
      if(dateTime.day == payingDay){
        money += debt;
        debt = 0;
      }
    }
  }
}