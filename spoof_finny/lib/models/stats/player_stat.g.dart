// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_stat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerStatAdapter extends TypeAdapter<PlayerStat> {
  @override
  final typeId = 16;

  @override
  PlayerStat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerStat(
      name: fields[0] as String,
      icon: fields[7] as String,
      type: fields[1] as StatType,
      maxValue: fields[3] == null ? 100 : (fields[3] as num).toInt(),
      minValue: fields[4] == null ? -100 : (fields[4] as num).toInt(),
      critMinValue: fields[5] == null ? -50 : (fields[5] as num?)?.toInt(),
      critMaxValue: (fields[6] as num?)?.toInt(),
    ).._currentValue = (fields[2] as num).toInt();
  }

  @override
  void write(BinaryWriter writer, PlayerStat obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj._currentValue)
      ..writeByte(3)
      ..write(obj.maxValue)
      ..writeByte(4)
      ..write(obj.minValue)
      ..writeByte(5)
      ..write(obj.critMinValue)
      ..writeByte(6)
      ..write(obj.critMaxValue)
      ..writeByte(7)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerStatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
