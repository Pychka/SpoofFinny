import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';

class CritStatValueGameEvent extends GameEvent {
  final String name;
  final StatValueState stat;

  const CritStatValueGameEvent({
    required this.name,
    required this.stat,
  });
}
