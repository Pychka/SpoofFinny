import 'package:hive_ce_flutter/hive_flutter.dart';

part 'stat_type.g.dart';

@HiveType(typeId: 17)
enum StatType{
  @HiveField(0)
  constant,
  @HiveField(1)
  temporary
}