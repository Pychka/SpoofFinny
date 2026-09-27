import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/shop_system/shop.dart';
part 'shop_manager.g.dart';

@HiveType(typeId: 26)
class ShopManager extends ChangeNotifier {
  @HiveField(0)
  Map<String, Shop> _shops;
  Shop? currentShop;

  ShopManager({Map<String, Shop> shopsValues = const {}}) : _shops = Map.from(shopsValues);
  List<Shop> get items => List.unmodifiable(_shops.values);  
  
  void addItem(Shop shop){
    _shops[shop.name] = shop;
    GameState.instance.saveUserInfo();
  }

  void removeItem(Shop shop) {
    _shops.remove(shop.name);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }

  Shop getShop(String name){
    final shop = _shops[name];
    if(shop == null) throw Exception('Not found shop $name');
    return shop;
  }
  

  void init(){
    if(GameState.instance.userInfo.isInitialized) return;
    
    GameState.instance.userInfo.shopManager.addItem(
      Shop(
        headerPath: '',
        assetPath: 'map/test_purple_house.png',
        name: 'Purple',
        relativeX:  0.645,
        relativeY: 0.6875,
        relativeWidth: 0.3625,
        relativeHeight: 0.3125
      )..addItem('Банан', 150)
      ..addItem('Яблоко', 100)
      ..addItem('Апельсин', 200)
    );
    GameState.instance.userInfo.shopManager.addItem(
      Shop(
        headerPath: '',
        assetPath: 'map/test_green_house.png',
        name: 'Green',
        relativeX: 0.645,
        relativeY: 0.3425,
        relativeWidth: 0.3625,
        relativeHeight: 0.3125
      )..addItem('Банан', 100)
      ..addItem('Яблоко', 60)
      ..addItem('Апельсин', 120)
    );
  }
}