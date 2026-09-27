// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatManagerAdapter extends TypeAdapter<StatManager> {
  @override
  final typeId = 15;

  @override
  StatManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatManager()
      .._stats = (fields[0] as Map).cast<String, PlayerStat>();
  }

  @override
  void write(BinaryWriter writer, StatManager obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._stats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
