import 'package:hive_ce_flutter/hive_ce_flutter.dart';
part 'operator.g.dart';

@HiveType(typeId: 23)
enum Operator {
  @HiveField(0)
  minus,
  @HiveField(1)
  plus,
  @HiveField(2)
  change,
  @HiveField(3)
  multi,
  @HiveField(4)
  divide
}