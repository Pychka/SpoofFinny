// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_time_manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameTimeManagerAdapter extends TypeAdapter<GameTimeManager> {
  @override
  final typeId = 8;

  @override
  GameTimeManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameTimeManager(currentDateTime: fields[0] as DateTime);
  }

  @override
  void write(BinaryWriter writer, GameTimeManager obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.currentDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameTimeManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
