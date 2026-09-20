// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_system.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperienceSystemAdapter extends TypeAdapter<ExperienceSystem> {
  @override
  final int typeId = 10;

  @override
  ExperienceSystem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExperienceSystem(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ExperienceSystem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currentLevel)
      ..writeByte(1)
      ..write(obj.currentExperience)
      ..writeByte(2)
      ..write(obj.factor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceSystemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
