import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/shop_system/shop.dart';
import 'package:spoof_finny/models/shop_system/shop_product.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
part 'shop_manager.g.dart';

@HiveType(typeId: 26)
class ShopManager extends ChangeNotifier {
  @HiveField(0)
  Map<String, Shop> _shops;
  @HiveField(1)
  Wallet wallet = Wallet();
  Shop? currentShop;
  final Random random = Random();
  @HiveField(2)
  GameTime nextUpdateTime = GameTime(totalSecondsValue: 0);
  late StreamSubscription onActionHappenSubscription;

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
  
  void purchase(){
    nextUpdateTime.addDays(7);
    final shops = List<Shop>.unmodifiable(_shops.values);
    for(final shop in shops){
      wallet.money += (shop.minNeedableBudget + (shop.maxNeedableBudget - shop.minNeedableBudget)) * max(0.5, random.nextDouble());
      double budgetRange = shop.maxNeedableBudget - shop.minNeedableBudget;
      double avg = 0.0;
      if (budgetRange > 0) {
        avg = min(1, max(0, (wallet.money - shop.minNeedableBudget) / budgetRange));
      }
      double plannedCost = shop.products.fold(0.0, (result, product) => result + getFinalWant(shop, product, wallet.money, avg));
      double balancer = wallet.money / plannedCost;
      double finalWant;
      for(final product in shop.products){
        finalWant = getFinalWant(shop, product, wallet.money, avg);
        if(plannedCost > wallet.money){
          finalWant = (finalWant * balancer);
        }
        if(GameState.instance.productsStorage.buy(wallet, product.item.name, finalWant.floor())){
          product.stockCount += finalWant.floor();
        }
      }
    }
  }

  void init(){
    for(final shop in _shops.values){
      for(final product in shop.products){
        product.init(i: true);
      }
    }
    if(GameState.instance.userInfo.timeManager.currentGameTime.totalSeconds < nextUpdateTime.totalSeconds){
      purchase();
    }
    onActionHappenSubscription = GameState.instance.userInfo.timeManager.onTimeChanged.listen((gameEvent) {
      if(GameState.instance.userInfo.timeManager.currentGameTime.totalSeconds < nextUpdateTime.totalSeconds) return;
      purchase();
    });
    
    if(GameState.instance.userInfo.isInitialized) return;
    
    GameState.instance.userInfo.shopManager.addItem(
      Shop(
        headerPath: '',
        assetPath: 'map/shop2_mark.png',
        name: 'Purple',
        relativeX: 0.645,
        relativeY: 0.6875,
        relativeWidth: 0.3625,
        relativeHeight: 0.3125,
        wantEvenly: 0.7,
        wantMax: 0.1,
        wantMin: 0.2,
      )
      ..addItem('Банан', 10, 40, 0.10)
      ..addItem('Апельсин', 5, 25, 0.05)
      ..addItem('Капучино', 15, 50, 0.15)
      ..addItem('Яблочный сок', 10, 40, 0.10)
      ..addItem('Чизкейк', 8, 30, 0.15)
      ..addItem('Шоколадный брауни', 8, 30, 0.15)
      ..addItem('Клубничное мороженое', 12, 45, 0.10)
      ..addItem('Борщ', 3, 15, 0.04)
      ..addItem('Куриный суп-лапша', 3, 15, 0.04)
      ..addItem('Грибной крем-суп', 3, 15, 0.04)
      ..addItem('Стейк из лосося с рисом', 2, 10, 0.02)
      ..addItem('Паста Болоньезе', 4, 15, 0.03)
      ..addItem('Куриное филе на гриле с пюре', 4, 15, 0.03)
    );

    GameState.instance.userInfo.shopManager.addItem(
      Shop(
        headerPath: '',
        assetPath: 'map/shop1_mark.png',
        name: 'Green',
        relativeX: 0.645,
        relativeY: 0.3425,
        relativeWidth: 0.3625,
        relativeHeight: 0.3125,
        wantEvenly: 0.3,
        wantMax: 0.5,
        wantMin: 0.2,
      )
      ..addItem('Яблоко', 30, 100, 0.25)
      ..addItem('Банан', 20, 70, 0.15)
      ..addItem('Апельсин', 15, 60, 0.15)
      ..addItem('Помидор', 20, 80, 0.15)
      ..addItem('Огурец', 25, 90, 0.15)
      ..addItem('Брокколи', 10, 40, 0.05)
      ..addItem('Зеленый чай', 10, 40, 0.05)
      ..addItem('Яблочный сок', 10, 40, 0.05)
    );
  }

  double getFinalWant(Shop shop, ShopProduct product, double budget, double avg) => 
    (product.wantMin * shop.wantMin)
    + (product.wantMax(budget) * shop.wantMax)
    + (product.wantEvenly(avg) * shop.wantEvenly);

    @override
  void dispose() {
    onActionHappenSubscription.cancel();
    super.dispose();
  }
}