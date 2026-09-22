import 'dart:async';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/quests/rewards/experience_reward.dart';

part 'experience_system.g.dart';

@HiveType(typeId: 10)
class ExperienceSystem {
  @HiveField(0)
  int _currentLevel = 0;
  @HiveField(1)
  int _currentExperience = 0;
  int _nextLevelExperience = 20;
  int skipedExp = 0;
  @HiveField(2)
  final int factor;
  GameEventBus? actionBus;
  late StreamSubscription onActionHappenSubscription;
  final ValueNotifier<int> currentLevelNotifier = ValueNotifier(0);
  final ValueNotifier<int> currentExperienceNotifier = ValueNotifier(0);
  final ValueNotifier<int> nextLevelExperienceNotifier = ValueNotifier(0);
  
  ExperienceSystem({
    int currentLevel = 0,
    int currentExperience = 0,
    this.factor = 1,
    this.actionBus,
  }) : _currentLevel = currentLevel, _currentExperience = currentExperience {
    nextLevelExperience = _getNextLevelExperience(_currentLevel);
    currentExperience = _currentExperience;
  }

  set currentExperience(int exp){
    _currentExperience = exp;
    currentExperienceNotifier.value = exp;
  }

  int get currentExperience => _currentExperience;

  set nextLevelExperience(int exp){
    _nextLevelExperience = exp;
    nextLevelExperienceNotifier.value = exp;
  }

  int get nextLevelExperience => _nextLevelExperience;

  set currentLevel(int level){
    _currentLevel = level;
    currentLevelNotifier.value = level;
    skipedExp = _getNextLevelExperience(level - 1);
  }

  int get currentLevel => _currentLevel;

  void init(){
    onActionHappenSubscription = actionBus!.onActionHappen.listen((gameEvent) {
      if(gameEvent is! CompleteTaskGameEvent) return;
      addExperience(gameEvent.rewards.whereType<ExperienceReward>().fold(0, (total, reward) => total + reward.amount));
    });
  }

  void addExperience(int experience){
    currentExperience = experience;
    while(currentExperience >= nextLevelExperience){
      currentLevel++;
      nextLevelExperience = _getNextLevelExperience(currentLevel);
    }
  }

  int _getNextLevelExperience(int level) => ((pow(level + 1, 2) / 2).floor() - level + 1) * factor;

  void dispose() {
    onActionHappenSubscription.cancel();
  }
}