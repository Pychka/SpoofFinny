// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_reward.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyRewardAdapter extends TypeAdapter<MoneyReward> {
  @override
  final typeId = 43;

  @override
  MoneyReward read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyReward(
      id: fields[0] as String,
      amount: (fields[1] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, MoneyReward obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyRewardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
