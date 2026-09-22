import 'dart:async';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/quests/quest.dart';

class QuestManager {
  List<Quest> activeQuests;
  GameEventBus actionBus;
  late StreamSubscription onActionHappenSubscription;
  QuestManager({
    required this.actionBus,
    required this.activeQuests
  });

  void init(){
    onActionHappenSubscription = actionBus.onActionHappen.listen((gameEvent) {
      for(final quest in activeQuests.toList()){
        quest.onEvent(gameEvent);
        if(quest.isCompleted()) {
          activeQuests.remove(quest);
        }
      }
    });
  }

  void dispose() {
    onActionHappenSubscription.cancel();
  }
}