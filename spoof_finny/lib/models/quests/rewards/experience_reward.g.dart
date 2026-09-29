// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_reward.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperienceRewardAdapter extends TypeAdapter<ExperienceReward> {
  @override
  final typeId = 45;

  @override
  ExperienceReward read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExperienceReward(
      id: fields[0] as String,
      amount: (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ExperienceReward obj) {
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
      other is ExperienceRewardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
