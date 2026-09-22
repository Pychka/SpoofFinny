import 'package:spoof_finny/models/item.dart';

class ItemFactory {
  final Map<String, Item Function()> _factories = {};
  ItemFactory._internal();

  static final ItemFactory instance = ItemFactory._internal();

  Item get(String name){
    final creator = _factories[name];

    if (creator == null) {
      throw Exception("Not found factory by key: $name");
    }

    return creator();
  }

  void register(String name, Item Function() factory) =>
    _factories[name] = factory;
}