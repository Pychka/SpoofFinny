import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/buy_game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
import 'package:spoof_finny/models/shop_system/shop_product.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import 'package:spoof_finny/models/user_info.dart';
part 'shop.g.dart';

@HiveType(typeId: 25)
class Shop extends ChangeNotifier{
  @HiveField(0)
  Map<String, ShopProduct> _products = {};
  @HiveField(1)
  String name;
  @HiveField(2)
  String assetPath;
  @HiveField(3)
  String headerPath;
  @HiveField(4)
  double relativeX;
  @HiveField(5)
  double relativeY;
  @HiveField(6)
  double relativeWidth;
  @HiveField(7)
  double relativeHeight;

  Shop({
    required this.name,
    required this.assetPath,
    required this.headerPath,
    required this.relativeX,
    required this.relativeY,
    required this.relativeWidth,
    required this.relativeHeight,
  });

    void addItem(String name, int count){
    final product = _products[name];
    if(product == null){
      final item = ItemFactory.instance.get(name, count);
      _products[name] = ShopProduct(item: item, hasDiscountValue: true, priceValue: item.basePrice, stockCountValue: count);
      notifyListeners();
    }
    else{
      product.stockCount += count;
    }
    GameState.instance.saveUserInfo();
  }

  void removeItem(ShopProduct product) {
    _products.remove(product.item.name);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }

  List<ShopProduct> get products => List.unmodifiable(_products.values);
  
  bool buy(String productName, int count, UserInfo userInfo){
    final product = _products[productName];
    if(product == null || product.stockCount < count) return false;
    
    if(!userInfo.moneyManager.wallet.get(product.price * count)) return false;

    userInfo.inventory.addItem(productName, count);
    product.stockCount -= count;
    if(product.stockCount <= 0){
      removeItem(product);
    }
    GameState.instance.gameEventBus.actionHappen(BuyGameEvent(itemName: productName, count: count, totalPrice: product.price * count, timeChangedEvent: GameTimeChangedEvent(from: GameTime(totalSecondsValue: 0), to: GameTime(totalSecondsValue: 1))));
    return true;
  }
}