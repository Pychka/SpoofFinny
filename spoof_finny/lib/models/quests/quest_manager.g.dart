// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestManagerAdapter extends TypeAdapter<QuestManager> {
  @override
  final typeId = 40;

  @override
  QuestManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestManager(activeQuestsValues: (fields[0] as List).cast<Quest>())
      ..lastUpdateTimeDaily = fields[1] as GameTime
      ..lastUpdateTimeWeekly = fields[2] as GameTime
      ..lastUpdateTimeMonthly = fields[3] as GameTime;
  }

  @override
  void write(BinaryWriter writer, QuestManager obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.activeQuestsValues)
      ..writeByte(1)
      ..write(obj.lastUpdateTimeDaily)
      ..writeByte(2)
      ..write(obj.lastUpdateTimeWeekly)
      ..writeByte(3)
      ..write(obj.lastUpdateTimeMonthly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
