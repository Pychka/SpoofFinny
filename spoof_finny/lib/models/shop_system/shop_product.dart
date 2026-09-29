import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/items/item.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
part 'shop_product.g.dart';

@HiveType(typeId: 27)
class ShopProduct {
  @HiveField(0)
  int _stockCount;
  @HiveField(1)
  String nameProduct;
  @HiveField(2)
  double _price;
  @HiveField(3)
  bool _hasDiscount;
  @HiveField(4)
  double markup;
  @HiveField(5)
  double priority;
  @HiveField(6)
  int minCount;
  @HiveField(7)
  int maxCount;
  @HiveField(8)
  double lossRate;
  @HiveField(9)
  double supplyRate;
  late final Item item;
  double get availability => _stockCount / ((maxCount - minCount) / 2 + minCount);

  int get spaceToMin => min(max(0, _stockCount - minCount), spaceToMax);
  int get spaceToMax => min(max(0, maxCount - _stockCount), GameState.instance.productsStorage.countOf(item.name));

  double get costToMin => spaceToMin * GameState.instance.productsStorage.costOf(item.name);
  double get costToMax => spaceToMax * GameState.instance.productsStorage.costOf(item.name);

  int get wantMin => spaceToMin;
  double wantMax(double budget) => min(spaceToMax.toDouble(), ((budget - priority) / price).floorToDouble());
  double wantEvenly(double avg) => spaceToMin + (spaceToMax - spaceToMin) * avg;

  ShopProduct({
    required this.nameProduct,
    int stockCountValue = 0,
    double markupValue = 0,
    double requirementValue = 0,
    int minCountValue = 0,
    int maxCountValue = 0,
    double priceValue = 0,
    double lossRateValue = 0,
    double supplyRateValue = 0,
    bool hasDiscountValue = false,
  }) : markup = markupValue,
    priority = requirementValue,
    minCount = minCountValue,
    maxCount = maxCountValue,
    _stockCount = stockCountValue,
    _price = priceValue,
    lossRate = lossRateValue,
    supplyRate = supplyRateValue,
    _hasDiscount = hasDiscountValue;

  ValueNotifier<int> stockCountNotifier = ValueNotifier(0);
  ValueNotifier<double> priceNotifier = ValueNotifier(0);
  ValueNotifier<bool> hasDiscountNotifier = ValueNotifier(false);

  void init({bool i = false}){
    item = ItemFactory.instance.get(nameProduct, 1);
    stockCountNotifier.value = _stockCount;
    priceNotifier.value = _price;
    hasDiscountNotifier.value = _hasDiscount;
  }

  int get stockCount => _stockCount;
  set stockCount(int value){
    _stockCount = value;
    stockCountNotifier.value = value;
  }

  double get price => _price * availability;
  set price(double value){
    _price = value;
    priceNotifier.value = value;
  }

  bool get hasDiscount => _hasDiscount;
  set hasDiscount(bool value){
    _hasDiscount = value;
    hasDiscountNotifier.value = value;
  }
}