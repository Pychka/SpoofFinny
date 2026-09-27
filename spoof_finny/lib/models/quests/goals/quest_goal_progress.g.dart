// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_goal_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestGoalProgressAdapter extends TypeAdapter<QuestGoalProgress> {
  @override
  final typeId = 30;

  @override
  QuestGoalProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestGoalProgress(
      requiredValue: (fields[3] as num).toInt(),
      itemName: fields[1] as String,
      title: fields[0] as String,
      timeChangedEvent: fields[99] as GameTimeChangedEvent,
    ).._currentValue = (fields[2] as num).toInt();
  }

  @override
  void write(BinaryWriter writer, QuestGoalProgress obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj._currentValue)
      ..writeByte(3)
      ..write(obj.requiredValue)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestGoalProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
