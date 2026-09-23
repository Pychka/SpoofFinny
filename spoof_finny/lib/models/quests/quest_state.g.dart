// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestStateAdapter extends TypeAdapter<QuestState> {
  @override
  final typeId = 16;

  @override
  QuestState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return QuestState.active;
      case 1:
        return QuestState.fail;
      case 2:
        return QuestState.completed;
      case 3:
        return QuestState.expired;
      default:
        return QuestState.active;
    }
  }

  @override
  void write(BinaryWriter writer, QuestState obj) {
    switch (obj) {
      case QuestState.active:
        writer.writeByte(0);
      case QuestState.fail:
        writer.writeByte(1);
      case QuestState.completed:
        writer.writeByte(2);
      case QuestState.expired:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
