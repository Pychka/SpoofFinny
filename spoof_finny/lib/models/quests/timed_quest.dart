import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/quests/quest.dart';

class TimedQuest extends Quest {
  DateTime endAt;

  TimedQuest({
    required this.endAt,
    required super.title,
    required super.description,
    required super.id,
    super.state
  });

  @override
  void onEvent(GameEvent action) {
    
  }
}