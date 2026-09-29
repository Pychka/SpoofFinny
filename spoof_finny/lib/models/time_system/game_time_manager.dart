import 'dart:async';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event_bus.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
part 'game_time_manager.g.dart';

@HiveType(typeId: 8)
class GameTimeManager {
  @HiveField(0)
  GameTime currentGameTime;
  late Timer _timer;
  late final GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;

  final StreamController<GameTimeChangedEvent> _timeChangedController = 
      StreamController<GameTimeChangedEvent>.broadcast();

  GameTimeManager({required this.currentGameTime});

  Stream<GameTimeChangedEvent> get onTimeChanged => _timeChangedController.stream;

  void advanceTime(int seconds) {
    GameTime oldGameTime = currentGameTime.createNew;
    currentGameTime.tickInSeconds(seconds);
    _timeChangedController.add(GameTimeChangedEvent(from: oldGameTime, to: currentGameTime));
  }
  void advanceTimeByReal(int seconds) {
    GameTime oldGameTime = currentGameTime.createNew;
    currentGameTime.tickInRealSeconds(seconds);
    _timeChangedController.add(GameTimeChangedEvent(from: oldGameTime, to: currentGameTime));
  }

  void init(GameEventBus gameEventBus){
    _gameEventBus = gameEventBus;
    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      if(gameEvent is GameTimeChangedEvent){
        advanceTime(gameEvent.to.totalSeconds - gameEvent.from.totalSeconds);
      }
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      advanceTimeByReal(1);
    });
  }

  void dispose() {
    _timeChangedController.close();
    _timer.cancel();
  }
}