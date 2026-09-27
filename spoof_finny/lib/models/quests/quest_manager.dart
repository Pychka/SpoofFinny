import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/quests/quest.dart';
import 'package:spoof_finny/models/quests/quest_state.dart';
import 'package:spoof_finny/models/quests/timed_quest.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';

import '../game_events/complete_task_game_event.dart';

class QuestManager extends ChangeNotifier {
  final List<Quest> _activeQuests;
  late GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;
  late StreamSubscription<GameTimeChangedEvent> _timeSubscription;
  List<Quest> get activeQuests => List.unmodifiable(_activeQuests);

  QuestManager({
    required this._activeQuests
  });

  void addQuest(Quest quest){
    _activeQuests.add(quest);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }


  void removeQuest(Quest quest) {
    _activeQuests.remove(quest);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }

  void init(GameEventBus gameEventBus){
    _gameEventBus = gameEventBus;

    _timeSubscription = GameState.instance.userInfo.timeManager.onTimeChanged.listen((gameTimeChangedEvent) {
      for(final timedQuest in _activeQuests.whereType<TimedQuest>()){
        if(timedQuest.endAt.totalSeconds <= gameTimeChangedEvent.to.totalSeconds){
          timedQuest.state = QuestState.expired;
          removeQuest(timedQuest);
          _gameEventBus.actionHappen(CompleteTaskGameEvent(taskId: timedQuest.id, state: timedQuest.state, rewards: timedQuest.rewards, timeChangedEvent: timedQuest.timeChangedEvent));
        }
      }
    });

    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      for(final quest in _activeQuests){
        quest.onEvent(gameEvent);
        if(quest.state != QuestState.active) {
          _gameEventBus.actionHappen(CompleteTaskGameEvent(taskId: quest.id, state: quest.state, rewards: quest.rewards, timeChangedEvent: GameTimeChangedEvent(from: GameTime(totalSecondsValue: 0), to: GameTime(totalSecondsValue: 1))));
          removeQuest(quest);
        }
      }
    });
  }

  @override
  void dispose() {
    _timeSubscription.cancel();
    onActionHappenSubscription.cancel();
    super.dispose();
  }
}