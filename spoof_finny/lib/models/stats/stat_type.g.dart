// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatTypeAdapter extends TypeAdapter<StatType> {
  @override
  final typeId = 17;

  @override
  StatType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StatType.constant;
      case 1:
        return StatType.temporary;
      default:
        return StatType.constant;
    }
  }

  @override
  void write(BinaryWriter writer, StatType obj) {
    switch (obj) {
      case StatType.constant:
        writer.writeByte(0);
      case StatType.temporary:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
