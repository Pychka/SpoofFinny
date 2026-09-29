// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_reward.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestRewardAdapter extends TypeAdapter<QuestReward> {
  @override
  final typeId = 41;

  @override
  QuestReward read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestReward(id: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, QuestReward obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestRewardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
