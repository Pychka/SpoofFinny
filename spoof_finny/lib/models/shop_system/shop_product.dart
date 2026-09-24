import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:spoof_finny/models/items/item.dart';
part 'shop_product.g.dart';

@HiveType(typeId: 24)
class ShopProduct {
  @HiveField(0)
  int _stockCount;
  @HiveField(1)
  final Item item;
  @HiveField(2)
  double _price;
  @HiveField(3)
  bool _hasDiscount;

  ShopProduct({
    required this.item,
    int stockCountValue = 0,
    double priceValue = 0,
    bool hasDiscountValue = false,
  }) : _stockCount = stockCountValue, _price = priceValue, _hasDiscount = hasDiscountValue;

  ValueNotifier<int> stockCountNotifier = ValueNotifier(0);
  ValueNotifier<double> priceNotifier = ValueNotifier(0);
  ValueNotifier<bool> hasDiscountNotifier = ValueNotifier(false);

  void init(){
    stockCountNotifier.value = _stockCount;
    priceNotifier.value = _price;
    hasDiscountNotifier.value = _hasDiscount;
  }

  int get stockCount => _stockCount;
  set stockCount(int value){
    _stockCount = value;
    stockCountNotifier.value = value;
  }

  double get price => _price;
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