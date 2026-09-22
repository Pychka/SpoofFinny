import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
part 'debit_card.g.dart';

@HiveType(typeId: 7)
class DebitCard extends MoneyStorage{
  DebitCard({super.money = 0.0});
}