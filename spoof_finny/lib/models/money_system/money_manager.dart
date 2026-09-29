
import 'dart:async';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event_bus.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
import 'package:spoof_finny/models/money_system/saving_account.dart';
import 'package:spoof_finny/models/money_system/term_account.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/quests/rewards/money_reward.dart';
import '../game_events/complete_task_game_event.dart';

part 'money_manager.g.dart';
@HiveType(typeId: 13)
class MoneyManager {
  @HiveField(0)
  Wallet wallet = Wallet();
  @HiveField(1)
  List<MoneyStorage> moneyBills = [SavingAccount(payingDay: 1)];
  late GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;
  late StreamSubscription onTimeChangedSubscription;


  double get allMoney => wallet.money + moneyBills.fold(0, (x, next) => x + next.money);
  
  List<MoneyStorage> allBillsWithoutOne(MoneyStorage storage) => [wallet, ...moneyBills].where((bill) => bill != storage).toList();

  MoneyManager({
    required this.wallet,
    required this.moneyBills,
  });

  void init(GameEventBus gameEventBus){
    wallet.init();
    for(final bill in moneyBills){
      bill.init();
    }
    
    _gameEventBus = gameEventBus;
    onTimeChangedSubscription = GameState.instance.userInfo.timeManager.onTimeChanged.listen((timeChanged) {
      for(final termAccount in moneyBills.whereType<TermAccount>()){
        termAccount.accrueInterest(timeChanged);
      }
    });

    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      if(gameEvent is CompleteTaskGameEvent){
        wallet.money += gameEvent.rewards.whereType<MoneyReward>().fold(0, (total, reward) => total + reward.amount);
        GameState.instance.saveUserInfo();
      }
    });
  }

  void dispose() {
    onActionHappenSubscription.cancel();
    onTimeChangedSubscription.cancel();
  }
}