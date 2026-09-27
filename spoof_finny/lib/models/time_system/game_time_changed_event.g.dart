// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_time_changed_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameTimeChangedEventAdapter extends TypeAdapter<GameTimeChangedEvent> {
  @override
  final typeId = 33;

  @override
  GameTimeChangedEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameTimeChangedEvent(
      from: fields[0] as GameTime,
      to: fields[1] as GameTime,
    );
  }

  @override
  void write(BinaryWriter writer, GameTimeChangedEvent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.to);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameTimeChangedEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
