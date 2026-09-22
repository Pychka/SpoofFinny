import 'dart:ui';
import 'package:flame/image_composition.dart';
import 'package:spoof_finny/models/experience_system.dart';
import 'package:spoof_finny/models/game_time_manager.dart';
import 'package:spoof_finny/models/item.dart';
import 'package:spoof_finny/models/item_factory.dart';
import 'package:spoof_finny/models/money_system/money_manager.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/player.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'package:spoof_finny/models/stats/stat_manager.dart';

part 'user_info.g.dart';

@HiveType(typeId: 0)
class UserInfo{
  @HiveField(0)
  GameTimeManager timeManager;

  @HiveField(1)
  String localeCode;
  @HiveField(2)
  String assetsPath;
  @HiveField(3)
  String petName;
  @HiveField(4)
  int countFrames;
  @HiveField(5)
  Vector2 textureSize;
  @HiveField(6)
  String playerName;
  Player player;
  @HiveField(7)
  MoneyManager moneyManager = MoneyManager(wallet: Wallet(), moneyBills: []);
  @HiveField(8)
  ExperienceSystem experienceSystem;
  @HiveField(10)
  StatManager statManager = StatManager(stats: {});
  @HiveField(9)
  List<Item> inventory;

  UserInfo({
    required this.timeManager,
    required this.localeCode,
    required this.assetsPath,
    required this.countFrames,
    required this.textureSize,
    required this.petName,
    required this.playerName,
    Player? player,
    ExperienceSystem? experienceSystem,
    this.inventory = const [],
  }) : player = player ?? Player(countFrames: countFrames, textureSize: textureSize, assetsFolder: assetsPath), experienceSystem = experienceSystem ?? ExperienceSystem(currentLevel: 0, currentExperience: 0, factor: 20);
  
  Locale get currentLocale {
    final parts = localeCode.split('_');
    return parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
  }

  void addItem({required String name, int count = 0}){
    Item item = inventory.firstWhereOrNull((item) => item.name == name) ?? ItemFactory.instance.get(name);
    item.count += count;
    inventory.add(item);
  }
}