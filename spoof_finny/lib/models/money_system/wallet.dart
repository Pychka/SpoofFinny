import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
part 'wallet.g.dart';

@HiveType(typeId: 6)
class Wallet extends MoneyStorage{
  Wallet({super.money = 0.0});
  @override
  String get billType => 'Кошелёк';
}