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
      displayedName: fields[0] as String,
      name: fields[1] as String,
      icon: fields[8] as String,
      type: fields[2] as StatType,
      maxValue: fields[4] == null ? 100 : (fields[4] as num).toInt(),
      minValue: fields[5] == null ? -100 : (fields[5] as num).toInt(),
      critMinValue: fields[6] == null ? -100 : (fields[6] as num?)?.toInt(),
      critMaxValue: (fields[7] as num?)?.toInt(),
    ).._currentValue = (fields[3] as num).toInt();
  }

  @override
  void write(BinaryWriter writer, PlayerStat obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.displayedName)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj._currentValue)
      ..writeByte(4)
      ..write(obj.maxValue)
      ..writeByte(5)
      ..write(obj.minValue)
      ..writeByte(6)
      ..write(obj.critMinValue)
      ..writeByte(7)
      ..write(obj.critMaxValue)
      ..writeByte(8)
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
