// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestGoalAdapter extends TypeAdapter<QuestGoal> {
  @override
  final typeId = 29;

  @override
  QuestGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestGoal(
      title: fields[0] as String,
      id: fields[1] as String,
      timeChangedEvent: fields[99] as GameTimeChangedEvent,
    );
  }

  @override
  void write(BinaryWriter writer, QuestGoal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
