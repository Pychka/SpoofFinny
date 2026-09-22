import 'dart:async';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_time_changed_event.dart';
part 'game_time_manager.g.dart';

@HiveType(typeId: 8)
class GameTimeManager {
  @HiveField(0)
  DateTime currentDateTime;
  
  final StreamController<GameTimeChangedEvent> _timeChangedController = 
      StreamController<GameTimeChangedEvent>.broadcast();

  GameTimeManager({required this.currentDateTime});

  Stream<GameTimeChangedEvent> get onTimeChanged => _timeChangedController.stream;

  void advanceTime(Duration duration) {
    DateTime oldDateTime = currentDateTime;
    currentDateTime = currentDateTime.add(duration);

    final event = GameTimeChangedEvent(from: oldDateTime, to: currentDateTime);
    _timeChangedController.add(event);
  }

  void dispose() {
    _timeChangedController.close();
  }
}