import 'package:hive/hive.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
part 'debit_card.g.dart';

@HiveType(typeId: 7)
class DebitCard extends MoneyStorage{
  DebitCard({required super.money});
}