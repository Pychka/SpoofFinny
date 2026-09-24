import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
import 'package:spoof_finny/models/game_events/eat_game_event.dart';
import 'package:spoof_finny/models/game_object.dart';
import 'package:spoof_finny/models/game_state.dart';

part 'item.g.dart';

@HiveType(typeId: 18)
class Item extends GameObject{
  @HiveField(1)
  final bool canStack;
  @HiveField(2)
  int countValue;
  @HiveField(3)
  final List<ChangeStatValueGameEvent> events;
  @HiveField(4)
  final String assetsFolder;

  ValueNotifier<int> countNotifier = ValueNotifier(0);
  Item({
    required super.name,
    required this.assetsFolder,
    this.events = const [],
    this.countValue = 0,
    this.canStack = true
  });

  int get count => countValue;

  set count(int value){
    countValue = value;
    countNotifier.value = value;
  }

  void use(){
    if(count <= 0) return;
    GameState.instance.gameEventBus.actionHappen(EatGameEvent(foodName: name, count: 1));
    for(final event in events){
      GameState.instance.gameEventBus.actionHappen(event);
    }
    count--;
  }

  void init(){
    countNotifier.value = countValue;
  }

  Item createNew(int count) => Item(canStack: canStack, assetsFolder: assetsFolder, countValue: count, name: name, events: events);
}