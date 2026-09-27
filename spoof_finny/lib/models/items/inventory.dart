import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/game_event_bus.dart';
import 'package:spoof_finny/models/game_events/use_item_game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/items/item.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
part 'inventory.g.dart';

@HiveType(typeId: 19)
class Inventory extends ChangeNotifier {
  @HiveField(0)
  Map<String, Item> _items = {};
  late GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;

  Inventory({this._items = const {}});

  List<Item> get items => List.unmodifiable(_items.values);

  void addItem(String name, int count){
    final oldItem = _items[name];
    if(oldItem == null){
      _items[name] = ItemFactory.instance.get(name, count)..count = count;
      notifyListeners();
    }
    else{
      oldItem.count += count;
    }
    GameState.instance.saveUserInfo();
  }

  void removeItem(Item item) {
    _items.remove(item.name);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }
  
  void init(GameEventBus gameEventBus){
    for(final item in items){
      item.init();
    }
    _gameEventBus = gameEventBus;
    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      if(gameEvent is UseItemGameEvent){
        if(gameEvent.item.count <= 0){
          removeItem(gameEvent.item);
        }
        GameState.instance.saveUserInfo();
      }
    });
  }

  @override
  void dispose() {
    onActionHappenSubscription.cancel();
    super.dispose();
  }
}