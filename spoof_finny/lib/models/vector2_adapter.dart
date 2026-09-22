import 'package:flame/extensions.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class Vector2Adapter extends TypeAdapter<Vector2> {
  @override
  final int typeId = 51;

  @override
  Vector2 read(BinaryReader reader) {
    final x = reader.readDouble();
    final y = reader.readDouble();
    return Vector2(x, y);
  }

  @override
  void write(BinaryWriter writer, Vector2 obj) {
    writer.writeDouble(obj.x);
    writer.writeDouble(obj.y);
  }
}
