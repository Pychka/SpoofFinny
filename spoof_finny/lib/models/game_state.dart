import 'package:flame/image_composition.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_time_manager.dart';
import 'package:spoof_finny/models/quests/goals/eat_quest_goal.dart';
import 'package:spoof_finny/models/quests/quest.dart';
import 'package:spoof_finny/models/quests/quest_manager.dart';
import 'package:spoof_finny/models/quests/rewards/experience_reward.dart';
import 'package:spoof_finny/models/quests/rewards/money_reward.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/user_info.dart';

class GameState {
  GameState._internal();

  static final GameState instance = GameState._internal();

  late UserInfo userInfo;
  late QuestManager questManager;
  GameEventBus actionBus = GameEventBus();

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
      info.statManager.addStat(PlayerStat(name: 'Настроение', type: StatType.constant));
      info.statManager.addStat(PlayerStat(name: 'Сытость', type: StatType.constant));
      info.statManager.addStat(PlayerStat(name: 'Усталость', type: StatType.constant));
      info.statManager.addStat(PlayerStat(name: 'Гигиена', type: StatType.constant));
      info.statManager.addStat(PlayerStat(name: 'Стресс', type: StatType.constant));
      StorageService.instance.saveUserInfo(info);
    }
    userInfo = info;
    questManager = QuestManager(actionBus: actionBus, activeQuests: [Quest(id: 1, title: 'Время перекусить', description: 'Перекус одна из важных состовляющих дня', rewards: [ExperienceReward(amount: 50), MoneyReward(amount: 50)], goals: [EatQuestGoal(currentValue: 0, requiredValue: 10, title: 'Съешь 10 бананов', itemName: 'banana')])]);
    questManager.init();
    userInfo.experienceSystem.actionBus = actionBus;
    userInfo.experienceSystem.init();
    userInfo.moneyManager.actionBus = actionBus;
    userInfo.moneyManager.init();
    userInfo.statManager.actionBus = actionBus;
    userInfo.statManager.init();
  }
}