import 'package:hive_ce_flutter/hive_ce_flutter.dart';
part 'game_object.g.dart';

@HiveType(typeId: 20)
class GameObject {
  @HiveField(0)
  String name;
  
  GameObject({
    required this.name
  });
}