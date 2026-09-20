import 'package:hive/hive.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
part 'wallet.g.dart';

@HiveType(typeId: 6)
class Wallet extends MoneyStorage{
  Wallet({required super.money});
}