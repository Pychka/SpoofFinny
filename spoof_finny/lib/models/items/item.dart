import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
import 'package:spoof_finny/models/game_events/eat_game_event.dart';
import 'package:spoof_finny/models/game_events/time_skipped.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';

part 'item.g.dart';

@HiveType(typeId: 18)
class Item extends TimeSkipped{
  @HiveField(0)
  String name;
  @HiveField(1)
  final bool canStack;
  @HiveField(2)
  int countValue;
  @HiveField(3)
  final List<ChangeStatValueGameEvent> events;
  @HiveField(4)
  final String assetsFolder;
  @HiveField(5)
  final double basePrice;

  ValueNotifier<int> countNotifier = ValueNotifier(0);
  Item({
    required this.name,
    required this.assetsFolder,
    required this.basePrice,
    this.events = const [],
    this.countValue = 0,
    this.canStack = true,
    required super.timeChangedEvent
  });

  int get count => countValue;

  set count(int value){
    countValue = value;
    countNotifier.value = value;
  }

  void use(){
    if(count <= 0) return;
    GameState.instance.gameEventBus.actionHappen(timeChangedEvent);
    GameState.instance.gameEventBus.actionHappen(EatGameEvent(foodName: name, count: 1, timeChangedEvent: timeChangedEvent, ));
    for(final event in events){
      GameState.instance.gameEventBus.actionHappen(event);
    }
    count--;
  }

  void init(){
    countNotifier.value = countValue;
  }

  Item createNew(int needableCount) => Item(canStack: canStack, basePrice: basePrice, assetsFolder: assetsFolder, countValue: needableCount, name: name, events: events, timeChangedEvent: timeChangedEvent);
}