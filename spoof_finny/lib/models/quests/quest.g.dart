// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestAdapter extends TypeAdapter<Quest> {
  @override
  final typeId = 11;

  @override
  Quest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quest(
      id: (fields[5] as num).toInt(),
      title: fields[0] as String,
      description: fields[1] as String,
      rewards: fields[30] == null
          ? const []
          : (fields[30] as List).cast<QuestReward>(),
      goals: fields[4] == null
          ? const []
          : (fields[4] as List).cast<QuestGoal>(),
      state: fields[2] == null ? QuestState.active : fields[2] as QuestState,
    );
  }

  @override
  void write(BinaryWriter writer, Quest obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.goals)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(30)
      ..write(obj.rewards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
