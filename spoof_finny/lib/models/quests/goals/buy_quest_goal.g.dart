// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_quest_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyQuestGoalAdapter extends TypeAdapter<BuyQuestGoal> {
  @override
  final typeId = 34;

  @override
  BuyQuestGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuyQuestGoal(
      requiredTotalPrice: (fields[6] as num).toDouble(),
      requiredValue: (fields[4] as num).toInt(),
      title: fields[0] as String,
      itemName: fields[2] as String,
      timeChangedEvent: fields[99] as GameTimeChangedEvent,
      id: fields[1] as String,
    ).._totalPrice = (fields[5] as num).toDouble();
  }

  @override
  void write(BinaryWriter writer, BuyQuestGoal obj) {
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
      ..write(obj._totalPrice)
      ..writeByte(6)
      ..write(obj.requiredTotalPrice)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyQuestGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
