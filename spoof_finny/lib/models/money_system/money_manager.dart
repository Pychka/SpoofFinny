
import 'dart:async';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/quests/rewards/money_reward.dart';

part 'money_manager.g.dart';
@HiveType(typeId: 13)
class MoneyManager {
  @HiveField(0)
  Wallet wallet = Wallet(money: 0.0);
  @HiveField(1)
  List<MoneyStorage> moneyBills = [];
  GameEventBus? actionBus;
  late StreamSubscription onActionHappenSubscription;

  
  MoneyManager({
    required this.wallet,
    required this.moneyBills,
    this.actionBus,
  });

  void init(){
    onActionHappenSubscription = actionBus!.onActionHappen.listen((gameEvent) {
      print('found');
      if(gameEvent is CompleteTaskGameEvent){
        wallet.money += gameEvent.rewards.whereType<MoneyReward>().fold(0, (total, reward) => total + reward.amount);
        print(wallet.money);
      }
    });
  }

  void dispose() {
    onActionHappenSubscription.cancel();
  }
}