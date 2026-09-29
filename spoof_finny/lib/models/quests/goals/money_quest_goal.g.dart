// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_quest_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyQuestGoalAdapter extends TypeAdapter<MoneyQuestGoal> {
  @override
  final typeId = 34;

  @override
  MoneyQuestGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyQuestGoal(
      requiredTotalValue: (fields[6] as num).toDouble(),
      requiredValue: (fields[4] as num).toInt(),
      title: fields[0] as String,
      itemName: fields[2] as String,
      timeChangedEvent: fields[99] as GameTimeChangedEvent,
      id: fields[1] as String,
    ).._totalValue = (fields[5] as num).toDouble();
  }

  @override
  void write(BinaryWriter writer, MoneyQuestGoal obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.itemName)
      ..writeByte(4)
      ..write(obj.requiredValue)
      ..writeByte(5)
      ..write(obj._totalValue)
      ..writeByte(6)
      ..write(obj.requiredTotalValue)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyQuestGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
