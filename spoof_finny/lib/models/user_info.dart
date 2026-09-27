import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/experience_system.dart';
import 'package:spoof_finny/models/player_factory.dart';
import 'package:spoof_finny/models/time_system/game_time_manager.dart';
import 'package:spoof_finny/models/items/inventory.dart';
import 'package:spoof_finny/models/money_system/money_manager.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/player.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/shop_system/shop_manager.dart';
import 'package:spoof_finny/models/stats/stat_manager.dart';

part 'user_info.g.dart';

@HiveType(typeId: 0)
class UserInfo{
  @HiveField(0)
  GameTimeManager timeManager;

  @HiveField(1)
  String localeCode;
  @HiveField(2)
  String playerIdValue;
  @HiveField(3)
  String petName;
  @HiveField(6)
  String playerName;
  @HiveField(13)
  int age;
  @HiveField(14)
  bool isInitialized;
  @HiveField(7)
  MoneyManager moneyManager = MoneyManager(wallet: Wallet(money: 200), moneyBills: []);
  @HiveField(8)
  ExperienceSystem experienceSystem;
  @HiveField(9)
  Inventory inventory = Inventory(items: {});
  @HiveField(10)
  StatManager statManager = StatManager(statsValues: {});
  @HiveField(11)
  ShopManager shopManager = ShopManager(shopsValues: {});
  ValueNotifier<String> playerIdNotifier = ValueNotifier('');

  UserInfo({
    required this.timeManager,
    required this.localeCode,
    required this.playerIdValue,
    required this.petName,
    required this.playerName,
    required this.age,
    required this.isInitialized,
    ExperienceSystem? experienceSystem,
  }) : experienceSystem = experienceSystem ?? ExperienceSystem(currentLevelValue: 0, currentExperienceValue: 0, factor: 20);
  
  set playerId(String playerId) {
    playerIdValue = playerId;
    playerIdNotifier.value = playerId;
  }

  String get playerId => playerIdValue; 

  Locale get currentLocale {
    final parts = localeCode.split('_');
    return parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
  }

  void dispose(){
    statManager.dispose();
    timeManager.dispose();
    experienceSystem.dispose();
  }

  Player get newPlayer => PlayerFactory.instance.get(playerId);
}