import 'package:hive_ce_flutter/hive_ce_flutter.dart';
part 'pet_sprites.g.dart';

@HiveType(typeId: 51)
class PetSprites {
  @HiveField(0)
  int width;
  @HiveField(1)
  int height;
  @HiveField(2)
  String path;

  PetSprites({
    required this.width,
    required this.height,
    required this.path,
  });
}