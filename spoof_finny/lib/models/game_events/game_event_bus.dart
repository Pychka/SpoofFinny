import 'dart:async';

import 'package:spoof_finny/models/game_events/game_event.dart';

class GameEventBus {
  final StreamController<GameEvent> _onActionController = StreamController<GameEvent>.broadcast();

  Stream<GameEvent> get onActionHappen => _onActionController.stream;

  void actionHappen(GameEvent action){
    _onActionController.add(action);
  }

  void dispose() {
    _onActionController.close();
  }
}