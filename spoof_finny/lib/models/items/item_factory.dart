import 'package:spoof_finny/models/items/item.dart';

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
}