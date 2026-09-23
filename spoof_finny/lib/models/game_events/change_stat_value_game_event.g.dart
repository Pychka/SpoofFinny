// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_stat_value_game_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChangeStatValueGameEventAdapter
    extends TypeAdapter<ChangeStatValueGameEvent> {
  @override
  final typeId = 22;

  @override
  ChangeStatValueGameEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChangeStatValueGameEvent(
      stat: fields[0] as PlayerStat,
      value: (fields[1] as num).toInt(),
      operator: fields[2] as Operator,
    );
  }

  @override
  void write(BinaryWriter writer, ChangeStatValueGameEvent obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.stat)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.operator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeStatValueGameEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
