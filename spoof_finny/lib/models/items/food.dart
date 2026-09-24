import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/game_events/use_item_game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/items/item.dart';
import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
part 'food.g.dart';

@HiveType(typeId: 24)
class Food extends Item {
  Food({
    required super.name,
    required super.assetsFolder,
    super.events = const [],
    super.countValue = 0,
    super.canStack = true
    });
  
  @override
  void use() {
    if(count <= 0) return;
    GameState.instance.gameEventBus.actionHappen(UseItemGameEvent(item: this, count: 1));
    for(final event in events){
      GameState.instance.gameEventBus.actionHappen(event);
    }
    count--;
  }

  @override
  Item createNew(int count) => Food(canStack: canStack, assetsFolder: assetsFolder, countValue: countValue, name: name, events: events);
}