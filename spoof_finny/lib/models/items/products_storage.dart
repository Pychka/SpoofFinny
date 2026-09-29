import 'dart:async';
import 'dart:math';
import 'package:hive_ce/hive_ce.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/shop_system/shop_product.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
part 'products_storage.g.dart';

@HiveType(typeId: 37)
class ProductsStorage {
  late StreamSubscription onActionHappenSubscription;
  @HiveField(0)
  Map<String, ShopProduct> _storage = {};
  @HiveField(1)
  GameTime nextUpdateTime = GameTime(totalSecondsValue: 0);
  @HiveField(2)
  double baseSupplyRate = 1;
  @HiveField(3)
  double baseLossRate = 1;
  @HiveField(4)
  double warehouseHealth = 1;

  ProductsStorage();

  ProductsStorage._internal();
  static final ProductsStorage instance = ProductsStorage._internal();

  void init(){
    if(GameState.instance.userInfo.timeManager.currentGameTime.totalSeconds < nextUpdateTime.totalSeconds){
      update();
    }
    onActionHappenSubscription = GameState.instance.userInfo.timeManager.onTimeChanged.listen((gameEvent) {
      if(GameState.instance.userInfo.timeManager.currentGameTime.totalSeconds < nextUpdateTime.totalSeconds) return;
      update();
    });
  }

  double costOf(String name) => _storage[name]?.price ?? 0.0;

  int countOf(String name) => _storage[name]?.stockCount ?? 0;

  bool buy(Wallet wallet, String name, int count){
    final product = _storage[name];
    if(product == null) return false;
    final cost = product.price * count;
    if(wallet.money - cost < 0) return false;
    wallet.money -= cost;
    product.stockCount -= count;
    return true;
  }

  void update(){
    nextUpdateTime.addDays(7);
    final List<ShopProduct> products = List.from(_storage.values);
    for(final product in products){
      product.stockCount -= max(product.minCount, (product.stockCount * baseLossRate + (2 - warehouseHealth)).toInt());
      product.stockCount += max(product.minCount, (product.stockCount * baseSupplyRate + (2 - warehouseHealth)).toInt());
      product.price = product.item.basePrice * product.availability;
    }
  }

  void dispose(){
    onActionHappenSubscription.cancel();
  }

  void addItem(String name, int minCount, int maxCount, double priority){
    final product = _storage[name];
    if(product == null){
      final item = ItemFactory.instance.get(name, 1);
      _storage[name] = ShopProduct(nameProduct: name, stockCountValue: maxCount, priceValue: item.basePrice, minCountValue: minCount, maxCountValue: maxCount)..init()..priority = priority;
    }
    GameState.instance.saveUserInfo();
  }
}