import 'dart:async';
import 'package:spoof_finny/models/game_time_changed_event.dart';

class GameTimeManager {
  DateTime _currentDateTime;
  
  final StreamController<GameTimeChangedEvent> _timeChangedController = 
      StreamController<GameTimeChangedEvent>.broadcast();

  GameTimeManager(this._currentDateTime);

  DateTime get currentDateTime => _currentDateTime;
  Stream<GameTimeChangedEvent> get onTimeChanged => _timeChangedController.stream;

  void advanceTime(Duration duration) {
    DateTime oldDateTime = _currentDateTime;
    _currentDateTime = _currentDateTime.add(duration);

    final event = GameTimeChangedEvent(from: oldDateTime, to: _currentDateTime);
    _timeChangedController.add(event);
  }

  void dispose() {
    _timeChangedController.close();
  }
}