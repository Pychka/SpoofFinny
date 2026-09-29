import 'dart:async';
import 'package:spoof_finny/models/game_events/game_event_bus.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
import 'package:spoof_finny/models/items/products_storage.dart';
import 'package:spoof_finny/models/player_factory.dart';
import 'package:spoof_finny/models/quests/goals/goal_factory.dart';
import 'package:spoof_finny/models/quests/rewards/rewards_factory.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_manager.dart';
import 'package:spoof_finny/models/quests/quest_manager.dart';
import 'package:spoof_finny/models/user_info.dart';

class GameState {
  GameState._internal();

  static final GameState instance = GameState._internal();

  late UserInfo userInfo;
  late QuestManager questManager;
  late ProductsStorage productsStorage;
  GameEventBus gameEventBus = GameEventBus();
  Timer? _autoSaveTimer;

  void init(){
    UserInfo? info = StorageService.instance.getUserInfo();
    if(info == null){
      baseInitializeSystem(info);
    }
    else{
      userInfo = info;
    }
    
    PlayerFactory.instance.init();
    if(userInfo.isInitialized){
      startGame();
    }
  }

  void saveUserInfo(){
    StorageService.instance.saveUserInfo(userInfo);
  }

  void dispose() {
    _autoSaveTimer?.cancel();
    questManager.dispose();
    userInfo.dispose();
    productsStorage.dispose();
  }

  void startGame(){
    userInfo.statManager.init(gameEventBus);
    userInfo.experienceSystem.init(gameEventBus);
    userInfo.moneyManager.init(gameEventBus);
    userInfo.inventory.init(gameEventBus);
    userInfo.timeManager.init(gameEventBus);    
    ItemFactory.instance.init();  
    GoalFactory.instance.init();
    RewardsFactory.instance.init();
    questManager = QuestManager(activeQuests: [])..init(gameEventBus);
    productsStorage = ProductsStorage()..addItem('Банан', 100, 300, 0.2)..addItem('Апельсин', 60, 200, 0.7)..addItem('Яблоко', 50, 200, 0.1);
    productsStorage.init();
    userInfo.shopManager.init();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      saveUserInfo();
    });
  }

  void baseInitializeSystem(UserInfo? info){
    info = UserInfo(
      timeManager: GameTimeManager(currentGameTime: GameTime(totalSecondsValue: 0)..addHours(6)),
      localeCode: "ru",
      playerIdValue: '',
      playerName: '',
      petName: 'Китик',
      age: 0,
      isInitialized: false,
    );
    userInfo = info;

    saveUserInfo();
  }
}