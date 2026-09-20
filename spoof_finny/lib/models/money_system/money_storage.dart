import 'package:hive/hive.dart';

part 'money_storage.g.dart';

@HiveType(typeId: 4)
class MoneyStorage{
  @HiveField(0)
  double money;
  MoneyStorage({required this.money});


  bool get(double needable){
    if(money >= needable){
      money -= needable;
      return true;
    }
    return false;
  }
}