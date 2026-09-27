import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/items/food.dart';
import 'package:spoof_finny/models/items/item.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';

class ItemFactory {
  final Map<String, Item> _factories = {};
  ItemFactory._internal();

  static final ItemFactory instance = ItemFactory._internal();

  Item get(String name, int count){
    final item = _factories[name];

    if (item == null) {
      throw Exception("Not found factory by key: $name");
    }

    return item.createNew(count);
  }

  void register(Item item) =>
    _factories[item.name] = item;

  void init(){
    register(
      Food(
        name: 'Банан',
        assetsFolder: 'food/fruits/banana.png',
        canStack: true,
        countValue: 1,
        basePrice: 10,
        events: [
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('satiety'),
            value: 2,
            operator: Operator.plus
          ),
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('hygiene'),
            value: 1,
            operator: Operator.minus
          ),
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('mood'),
            value: 3,
            operator: Operator.plus
          ),
          ],
          timeChangedEvent: GameTimeChangedEvent(
            from: GameTime(totalSecondsValue: 0),
            to: GameTime(totalSecondsValue: 0)..addMinutes(1)
          ) 
        )
      );
    register(
      Food(
        name: 'Апельсин',
        assetsFolder: 'food/fruits/orange.png',
        canStack: true,
        countValue: 1,
        basePrice: 15,
        events: [
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('satiety'),
            value: 1,
            operator: Operator.plus
          ),
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('hygiene'),
            value: 2,
            operator: Operator.minus
          ),
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('mood'),
            value: 4,
            operator: Operator.plus
          ),
          ],
          timeChangedEvent: GameTimeChangedEvent(
            from: GameTime(totalSecondsValue: 0),
            to: GameTime(totalSecondsValue: 0)..addMinutes(2)
          ) 
        )
      );
    register(
      Food(
        name: 'Яблоко',
        assetsFolder: 'food/fruits/apple.png',
        canStack: true,
        countValue: 1,
        basePrice: 5,
        events: [
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('satiety'),
            value: 1,
            operator: Operator.plus
          ),
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('hygiene'),
            value: 1,
            operator: Operator.minus
          ),
          ChangeStatValueGameEvent(
            stat: GameState.instance.userInfo.statManager.getStat('mood'),
            value: 2,
            operator: Operator.plus
          ),
          ],
          timeChangedEvent: GameTimeChangedEvent(
            from: GameTime(totalSecondsValue: 0),
            to: GameTime(totalSecondsValue: 0)..addMinutes(1)
          ) 
        )
      );
  }
}