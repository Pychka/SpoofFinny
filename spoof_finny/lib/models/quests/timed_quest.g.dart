// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timed_quest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimedQuestAdapter extends TypeAdapter<TimedQuest> {
  @override
  final typeId = 32;

  @override
  TimedQuest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimedQuest(
        endAt: fields[7] as GameTime,
        title: fields[0] as String,
        description: fields[1] as String,
        id: (fields[5] as num).toInt(),
        state: fields[2] == null ? QuestState.active : fields[2] as QuestState,
        timeChangedEvent: fields[99] as GameTimeChangedEvent,
      )
      ..goals = (fields[4] as List).cast<QuestGoal>()
      ..rewards = (fields[30] as List).cast<QuestReward>();
  }

  @override
  void write(BinaryWriter writer, TimedQuest obj) {
    writer
      ..writeByte(8)
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
      ..writeByte(7)
      ..write(obj.endAt)
      ..writeByte(30)
      ..write(obj.rewards)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimedQuestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
