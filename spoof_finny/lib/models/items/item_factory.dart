import 'dart:math';
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
  static final Random random = Random();
  static final ItemFactory instance = ItemFactory._internal();

  Item getRandomItem<T extends Item>(){
    final items = _factories.values.whereType<T>().toList();
    return items[random.nextInt(items.length)].createNew(0);
  }

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
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 2, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 3, operator: Operator.plus),
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
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 1, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 2, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 4, operator: Operator.plus),
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
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 1, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 2, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(1)
        ) 
      )
    );

    register(
      Food(
        name: 'Помидор',
        assetsFolder: 'food/vegetables/tomato.png',
        canStack: true,
        countValue: 1,
        basePrice: 6,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 1, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 1, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(1)
        ) 
      )
    );

    register(
      Food(
        name: 'Брокколи',
        assetsFolder: 'food/vegetables/broccoli.png',
        canStack: true,
        countValue: 1,
        basePrice: 8,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 2, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 0, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 1, operator: Operator.minus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(2)
        ) 
      )
    );

    register(
      Food(
        name: 'Огурец',
        assetsFolder: 'food/vegetables/cucumber.png',
        canStack: true,
        countValue: 1,
        basePrice: 4,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 1, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 0, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 1, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(1)
        ) 
      )
    );

    register(
      Food(
        name: 'Зеленый чай',
        assetsFolder: 'food/drinks/green_tea.png',
        canStack: true,
        countValue: 1,
        basePrice: 12,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 1, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 0, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 2, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('fatigue'), value: 2, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(3)
        ) 
      )
    );

    register(
      Food(
        name: 'Капучино',
        assetsFolder: 'food/drinks/cappuccino.png',
        canStack: true,
        countValue: 1,
        basePrice: 25,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 1, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 4, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('fatigue'), value: 8, operator: Operator.plus), 
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(3)
        ) 
      )
    );

    register(
      Food(
        name: 'Яблочный сок',
        assetsFolder: 'food/drinks/apple_juice.png',
        canStack: true,
        countValue: 1,
        basePrice: 15,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 1, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 0, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 3, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(2)
        ) 
      )
    );

    register(
      Food(
        name: 'Чизкейк',
        assetsFolder: 'food/desserts/cheesecake.png',
        canStack: true,
        countValue: 1,
        basePrice: 40,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 3, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 2, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 8, operator: Operator.plus), 
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(4)
        ) 
      )
    );

    register(
      Food(
        name: 'Шоколадный брауни',
        assetsFolder: 'food/desserts/brownie.png',
        canStack: true,
        countValue: 1,
        basePrice: 45,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 3, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 3, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 10, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('fatigue'), value: 3, operator: Operator.plus), 
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(4)
        ) 
      )
    );

    register(
      Food(
        name: 'Клубничное мороженое',
        assetsFolder: 'food/desserts/strawberry_ice_cream.png',
        canStack: true,
        countValue: 1,
        basePrice: 30,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 2, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 2, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 7, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(3)
        ) 
      )
    );

    register(
      Food(
        name: 'Борщ',
        assetsFolder: 'food/main/borscht.png',
        canStack: false, 
        countValue: 1,
        basePrice: 60,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 12, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 2, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 5, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('fatigue'), value: 2, operator: Operator.minus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(10)
        )
      )
    );
    register(
      Food(
        name: 'Куриный суп-лапша',
        assetsFolder: 'food/main/chicken_soup.png',
        canStack: false,
        countValue: 1,
        basePrice: 50,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 10, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 4, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(10)
        )
      )
    );
    register(
      Food(
        name: 'Грибной крем-суп',
        assetsFolder: 'food/main/mushroom_soup.png',
        canStack: false,
        countValue: 1,
        basePrice: 55,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 9, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 5, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(8)
      )
      )
    );

    register(
      Food(
        name: 'Стейк из лосося с рисом',
        assetsFolder: 'food/main/salmon_rice.png',
        canStack: false,
        countValue: 1,
        basePrice: 90,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 18, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus), 
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 6, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(15)
        )
      )
    );
    register(
      Food(
        name: 'Паста Болоньезе',
        assetsFolder: 'food/main/pasta_bolognese.png',
        canStack: false,
        countValue: 1,
        basePrice: 75,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 15, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 3, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 7, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('fatigue'), value: 3, operator: Operator.minus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
        from: GameTime(totalSecondsValue: 0),
        to: GameTime(totalSecondsValue: 0)..addMinutes(12)
        )
      )
    );
    register(
      Food(
        name: 'Куриное филе на гриле с пюре',
        assetsFolder: 'food/main/chicken_puree.png',
        canStack: false,
        countValue: 1,
        basePrice: 70,
        events: [
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('satiety'), value: 14, operator: Operator.plus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('hygiene'), value: 1, operator: Operator.minus),
          ChangeStatValueGameEvent(stat: GameState.instance.userInfo.statManager.getStat('mood'), value: 5, operator: Operator.plus),
        ],
        timeChangedEvent: GameTimeChangedEvent(
          from: GameTime(totalSecondsValue: 0),
          to: GameTime(totalSecondsValue: 0)..addMinutes(12)
        )
      )
    );
  }
}