// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressGoalAdapter extends TypeAdapter<ProgressGoal> {
  @override
  final typeId = 31;

  @override
  ProgressGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressGoal(
      progress: fields[1] as QuestGoalProgress,
      title: fields[0] as String,
      timeChangedEvent: fields[99] as GameTimeChangedEvent,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressGoal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.progress)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
