import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:spoof_finny/models/game_events/game_event_bus.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/quests/goals/goal_factory.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/quest.dart';
import 'package:spoof_finny/models/quests/quest_state.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/quests/rewards/rewards_factory.dart';
import 'package:spoof_finny/models/quests/timed_quest.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import '../game_events/complete_task_game_event.dart';
part 'quest_manager.g.dart';

@HiveType(typeId: 40)
class QuestManager extends ChangeNotifier {
  @HiveField(0)
  List<Quest> activeQuestsValues;
  late GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;
  late StreamSubscription<GameTimeChangedEvent> _timeSubscription;
  List<Quest> get activeQuests => List.unmodifiable(activeQuestsValues);
  @HiveField(1)
  GameTime lastUpdateTimeDaily = GameTime(totalSecondsValue: 0);
  @HiveField(2)
  GameTime lastUpdateTimeWeekly = GameTime(totalSecondsValue: 0);
  @HiveField(3)
  GameTime lastUpdateTimeMonthly = GameTime(totalSecondsValue: 0);
  final Random random = Random();
  QuestManager({
    required this.activeQuestsValues
  });

  List<TimedQuest> get dailyQuests => activeQuestsValues.whereType<TimedQuest>().where((timedQuest) => timedQuest.endAt.totalSeconds - timedQuest.startAt.totalSeconds == GameTime.secondsInDay).toList();

  List<TimedQuest> get weeklyQuests => activeQuestsValues.whereType<TimedQuest>().where((timedQuest) => timedQuest.endAt.totalSeconds - timedQuest.startAt.totalSeconds == GameTime.secondsInDay * 7).toList();

  List<TimedQuest> get monthlyQuests => activeQuestsValues.whereType<TimedQuest>().where((timedQuest) => timedQuest.endAt.totalSeconds - timedQuest.startAt.totalSeconds == GameTime.secondsInDay * 30).toList();

  List<Quest> get statedQuests => activeQuestsValues.where((quest) => quest.runtimeType == Quest).toList();

  void addQuest(Quest quest){
    activeQuestsValues.add(quest);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }


  void removeQuest(Quest quest) {
    activeQuestsValues.remove(quest);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }

  void init(GameEventBus gameEventBus){
    _gameEventBus = gameEventBus;

    _timeSubscription = GameState.instance.userInfo.timeManager.onTimeChanged.listen((gameTimeChangedEvent) {
      for(final timedQuest in activeQuestsValues.whereType<TimedQuest>().toList()){
        if(timedQuest.endAt.totalSeconds <= gameTimeChangedEvent.to.totalSeconds){
          timedQuest.state = QuestState.expired;
          removeQuest(timedQuest);
          _gameEventBus.actionHappen(CompleteTaskGameEvent(taskId: timedQuest.id, state: timedQuest.state, rewards: timedQuest.rewards, timeChangedEvent: timedQuest.timeChangedEvent));
        }
      }
      final next = lastUpdateTimeDaily.createNew..addDays(1);
      if(gameTimeChangedEvent.to.totalSeconds <= next.totalSeconds) return;

      generate(1, 3);
      lastUpdateTimeDaily = gameTimeChangedEvent.to;
      final nextWeek = lastUpdateTimeWeekly.createNew..addDays(7);
      if(nextWeek.totalSeconds <= gameTimeChangedEvent.to.totalSeconds){
        generate(7, 7);
        lastUpdateTimeWeekly = gameTimeChangedEvent.to;
      }
      final nextMonth = lastUpdateTimeMonthly.createNew..addDays(30);
      if(nextMonth.totalSeconds <= gameTimeChangedEvent.to.totalSeconds){
        generate(30, 7);
        lastUpdateTimeMonthly = gameTimeChangedEvent.to;
      }
      if(statedQuests.isEmpty){
        generate(-1, 7);
      }
    });

    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      for(final quest in activeQuestsValues.toList()){
        quest.onEvent(gameEvent);
        if(quest.state != QuestState.active) {
          _gameEventBus.actionHappen(CompleteTaskGameEvent(taskId: quest.id, state: quest.state, rewards: quest.rewards, timeChangedEvent: GameTimeChangedEvent(from: GameTime(totalSecondsValue: 0), to: GameTime(totalSecondsValue: 1))));
          removeQuest(quest);
        }
      }
    });
    firstInit();
  }

  void firstInit(){
    if(GameState.instance.userInfo.isInitialized) return;

    generate(1, 3);
    generate(7, 7);
    generate(30, 7);
    generate(-1, 7);
  }

  void generate(int period, int count){
    final level = GameState.instance.userInfo.experienceSystem.currentLevel;
    final kLvl = 1 + level / 5;
    final kMoney = 1 + log(1 + GameState.instance.userInfo.moneyManager.allMoney / 500) * ln10;
    final w = period == 1 ? 1 : period == 7 ? 4.5 : period == 30 ? 15 : 7;
    HashSet<QuestGoal> goals = HashSet();
    final gameTime = GameState.instance.userInfo.timeManager.currentGameTime.createNew;
    for(int index = 0; index < count; index++){
      Quest quest = Quest(
        title: '',
        description: '',
        state: QuestState.active,
        id: 'task_${GameState.instance.userInfo.timeManager.currentGameTime.day}_${index + 1}',
        timeChangedEvent: GameTimeChangedEvent(
          from: gameTime.createNew,
          to: gameTime.createNew
        )
      );
      if(period != -1){
        quest = TimedQuest.createByQuest(quest, gameTime.createNew, gameTime.createNew..addDays(period));
      }
      final countGoals = level >= 18 ? 2 : level >= 12 ? 1 : 3;
      QuestGoal goal;
      for(int i = 0; i < countGoals; i++){
        do{
          goal = GoalFactory.instance.getRandomQuestGoal();
          print(goal);
        }
        while(goals.contains(goal));
        goals.add(goal);
        quest.goals.add(goal..setTarget((goal.baseValue * kLvl * kMoney * w).roundToDouble()));
      }
      QuestReward reward;
      for(int i = 0; i < countGoals; i++){
        reward = RewardsFactory.instance.getRandomQuestReward();
        quest.rewards.add(
          reward..init(
            (reward.baseValue * kLvl * kMoney * w).roundToDouble(),
          )
        );
      }
      addQuest(quest);
    }
  }

  @override
  void dispose() {
    _timeSubscription.cancel();
    onActionHappenSubscription.cancel();
    super.dispose();
  }
}