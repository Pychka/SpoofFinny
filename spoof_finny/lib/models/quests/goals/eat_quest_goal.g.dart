// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eat_quest_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EatQuestGoalAdapter extends TypeAdapter<EatQuestGoal> {
  @override
  final typeId = 32;

  @override
  EatQuestGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EatQuestGoal(
      requiredValue: (fields[3] as num).toInt(),
      title: fields[0] as String,
      itemName: fields[1] as String,
      timeChangedEvent: fields[99] as GameTimeChangedEvent,
    );
  }

  @override
  void write(BinaryWriter writer, EatQuestGoal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.itemName)
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
      other is EatQuestGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
