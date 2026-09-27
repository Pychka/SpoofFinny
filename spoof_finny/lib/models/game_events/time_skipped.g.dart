// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_skipped.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeSkippedAdapter extends TypeAdapter<TimeSkipped> {
  @override
  final typeId = 29;

  @override
  TimeSkipped read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeSkipped(timeChangedEvent: fields[99] as GameTimeChangedEvent);
  }

  @override
  void write(BinaryWriter writer, TimeSkipped obj) {
    writer
      ..writeByte(1)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSkippedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
