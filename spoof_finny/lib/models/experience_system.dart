import 'dart:async';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/quests/rewards/experience_reward.dart';

import 'game_events/complete_task_game_event.dart';

part 'experience_system.g.dart';

@HiveType(typeId: 10)
class ExperienceSystem {
  @HiveField(0)
  int _currentLevel = 0;
  @HiveField(1)
  int _currentExperience = 0;
  int skipedExp = 0;
  @HiveField(2)
  final int factor;
  @HiveField(3)
  int _nextLevelExperience = 20;
  late GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;
  final ValueNotifier<int> currentLevelNotifier = ValueNotifier(0);
  final ValueNotifier<int> currentExperienceNotifier = ValueNotifier(0);
  final ValueNotifier<int> nextLevelExperienceNotifier = ValueNotifier(0);
  
  ExperienceSystem({
    int currentLevelValue = 0,
    int currentExperienceValue = 0,
    this.factor = 1,
  }) : _currentLevel = currentLevelValue, _currentExperience = currentExperienceValue;

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

  void init(GameEventBus gameEventBus){
    _gameEventBus = gameEventBus;

    currentLevelNotifier.value = _currentLevel;
    currentExperienceNotifier.value = _currentExperience;
    nextLevelExperience = _getNextLevelExperience(_currentLevel);
    skipedExp = _getNextLevelExperience(_currentLevel - 1);

    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      if(gameEvent is! CompleteTaskGameEvent) return;
      addExperience(gameEvent.rewards.whereType<ExperienceReward>().fold(0, (total, reward) => total + reward.amount));
    });
  }

  double get getPercentOfNextLevel => (_currentExperience - skipedExp) / (_nextLevelExperience - skipedExp);

  void addExperience(int experience){
    currentExperience += experience;
    while(currentExperience >= nextLevelExperience){
      currentLevel++;
      nextLevelExperience = _getNextLevelExperience(currentLevel);
    }
    StorageService.instance.saveUserInfo(GameState.instance.userInfo);
  }

  int _getNextLevelExperience(int level) => level < 0 ? 0 : ((pow(level + 1, 2) / 2).floor() - level + 2) * factor;

  void dispose() {
    onActionHappenSubscription.cancel();
  }
}