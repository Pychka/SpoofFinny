import 'dart:async';
import 'package:flame/image_composition.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_time_manager.dart';
import 'package:spoof_finny/models/items/food.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
import 'package:spoof_finny/models/quests/goals/eat_quest_goal.dart';
import 'package:spoof_finny/models/quests/quest.dart';
import 'package:spoof_finny/models/quests/quest_manager.dart';
import 'package:spoof_finny/models/quests/rewards/experience_reward.dart';
import 'package:spoof_finny/models/quests/rewards/money_reward.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/stats/stat_type.dart';
import 'package:spoof_finny/models/user_info.dart';

import 'game_events/change_stat_value_game_event.dart';

class GameState {
  GameState._internal();

  static final GameState instance = GameState._internal();

  late UserInfo userInfo;
  late QuestManager questManager;
  GameEventBus gameEventBus = GameEventBus();
  Timer? _autoSaveTimer;

  void init(){
    UserInfo? info = StorageService.instance.getUserInfo();
    if(info == null){
      info = UserInfo(
        timeManager: GameTimeManager(currentDateTime: DateTime.now()),
        localeCode: "ru",
        assetsPath: 'kitty/',
        playerName: '',
        petName: 'Китик',
        countFrames: 8,
        textureSize: Vector2.all(128),
      );
      info.statManager.addStat(PlayerStat(name: 'Настроение', icon: '🙂', type: StatType.constant, currentValue: 0));
      info.statManager.addStat(PlayerStat(name: 'Сытость', icon: '😋', type: StatType.constant, currentValue: 0));
      info.statManager.addStat(PlayerStat(name: 'Усталость', icon: '🥱', type: StatType.constant, currentValue: 0));
      info.statManager.addStat(PlayerStat(name: 'Гигиена', icon: '🧼', type: StatType.constant, currentValue: 0));
      info.statManager.addStat(PlayerStat(name: 'Стресс',  icon: '🤯', type: StatType.constant, currentValue: 0));
      StorageService.instance.saveUserInfo(info);
    }
    userInfo = info;
    questManager = QuestManager(activeQuests: [Quest(id: 1, title: 'Время перекусить', description: 'Перекус одна из важных состовляющих дня', rewards: [ExperienceReward(amount: 50), MoneyReward(amount: 50)], goals: [EatQuestGoal(currentValue: 0, requiredValue: 10, title: 'Съешь 10 бананов', itemName: 'Банан')])]);
  
    initItemFactory();
    info.inventory.addItem('Яблоко', 10);
    info.inventory.addItem('Апельсин', 10);
    info.inventory.addItem('Банан', 10);
    questManager.init(gameEventBus);
    userInfo.experienceSystem.init(gameEventBus);
    userInfo.moneyManager.init(gameEventBus);
    userInfo.statManager.init(gameEventBus);
    userInfo.inventory.init(gameEventBus);
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      saveUserInfo();
    });
  }

  void saveUserInfo(){
    StorageService.instance.saveUserInfo(userInfo);
  }

  void dispose() {
    _autoSaveTimer?.cancel();
    questManager.dispose();
    userInfo.dispose();
  }

  void initItemFactory(){
    ItemFactory.instance.register(
      Food(
        name: 'Банан',
        assetsFolder: 'food/fruits/banana.png',
        canStack: true,
        countValue: 10,
        events: [
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Сытость'),
            value: 2,
            operator: Operator.plus
          ),
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Гигиена'),
            value: 1,
            operator: Operator.minus
          ),
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Настроение'),
            value: 3,
            operator: Operator.plus
          ),
          ]
        )
      );
    ItemFactory.instance.register(
      Food(
        name: 'Апельсин',
        assetsFolder: 'food/fruits/orange.png',
        canStack: true,
        countValue: 10,
        events: [
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Сытость'),
            value: 1,
            operator: Operator.plus
          ),
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Гигиена'),
            value: 2,
            operator: Operator.minus
          ),
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Настроение'),
            value: 4,
            operator: Operator.plus
          ),
          ]
        )
      );
    ItemFactory.instance.register(
      Food(
        name: 'Яблоко',
        assetsFolder: 'food/fruits/apple.png',
        canStack: true,
        countValue: 10,
        events: [
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Сытость'),
            value: 1,
            operator: Operator.plus
          ),
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Гигиена'),
            value: 1,
            operator: Operator.minus
          ),
          ChangeStatValueGameEvent(
            stat: userInfo.statManager.getStat('Настроение'),
            value: 2,
            operator: Operator.plus
          ),
          ]
        )
      );
  }
}