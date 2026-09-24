import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/shop_system/shop_product.dart';
import 'package:spoof_finny/models/user_info.dart';
part 'shop.g.dart';

@HiveType(typeId: 25)
class Shop extends ChangeNotifier{
  @HiveField(0)
  Map<String, ShopProduct> _products = {};
  @HiveField(1)
  String name;
  @HiveField(2)
  String logoPath;
  @HiveField(3)
  String headerPath;

  Shop({
    required this.name,
    required this.logoPath,
    required this.headerPath,
  });

  List<ShopProduct> get products => List.unmodifiable(_products.values);
  
  bool buy(String productName, int count, UserInfo userInfo){
    final product = _products[productName];
    if(product == null || product.stockCount < count) return false;
    
    if(!userInfo.moneyManager.wallet.get(product.price * count)) return false;

    userInfo.inventory.addItem(productName, count);
    return true;
  }
}