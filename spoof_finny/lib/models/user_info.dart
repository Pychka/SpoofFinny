import 'dart:ui';
import 'package:flame/image_composition.dart';
import 'package:spoof_finny/models/experience_system.dart';
import 'package:spoof_finny/models/game_time_manager.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/player.dart';
import 'package:hive/hive.dart';

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
  Wallet wallet = Wallet(money: 0.0);
  @HiveField(8)
  List<MoneyStorage> moneyBills = [];
  @HiveField(9)
  ExperienceSystem experienceSystem;

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
  }) : player = player ?? Player(countFrames: countFrames, textureSize: textureSize, assetsFolder: assetsPath), experienceSystem = experienceSystem ?? ExperienceSystem(0, 0, 20);
  
  Locale get currentLocale {
    final parts = localeCode.split('_');
    return parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
  }
}