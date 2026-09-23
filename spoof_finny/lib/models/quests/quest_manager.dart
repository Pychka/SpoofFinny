import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/quests/quest.dart';

import '../game_events/complete_task_game_event.dart';

class QuestManager extends ChangeNotifier {
  final List<Quest> _activeQuests;
  late GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;

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
    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      for(final quest in activeQuests.toList()){
        quest.onEvent(gameEvent);
        if(quest.isCompleted()) {
          _gameEventBus.actionHappen(CompleteTaskGameEvent(taskId: quest.id, rewards: quest.rewards));
          removeQuest(quest);
        }
      }
    });
  }

  @override
  void dispose() {
    onActionHappenSubscription.cancel();
    super.dispose();
  }
}