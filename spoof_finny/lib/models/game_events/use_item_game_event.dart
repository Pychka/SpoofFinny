import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/items/item.dart';

class UseItemGameEvent extends GameEvent {
  final Item item;
  final int count;

  const UseItemGameEvent({
    required this.item,
    required this.count,
  });
}