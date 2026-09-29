// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_reward.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatRewardAdapter extends TypeAdapter<StatReward> {
  @override
  final typeId = 42;

  @override
  StatReward read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatReward(
      id: fields[0] as String,
      amount: (fields[1] as num).toInt(),
      stat: fields[2] as PlayerStat,
      operator: fields[3] as Operator,
    );
  }

  @override
  void write(BinaryWriter writer, StatReward obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.stat)
      ..writeByte(3)
      ..write(obj.operator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatRewardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
