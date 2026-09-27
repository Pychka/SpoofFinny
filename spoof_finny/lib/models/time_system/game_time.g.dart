// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameTimeAdapter extends TypeAdapter<GameTime> {
  @override
  final typeId = 28;

  @override
  GameTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameTime(totalSecondsValue: (fields[0] as num).toInt());
  }

  @override
  void write(BinaryWriter writer, GameTime obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.totalSecondsValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
