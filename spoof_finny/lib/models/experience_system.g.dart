// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_system.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperienceSystemAdapter extends TypeAdapter<ExperienceSystem> {
  @override
  final typeId = 10;

  @override
  ExperienceSystem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExperienceSystem(
        factor: fields[2] == null ? 1 : (fields[2] as num).toInt(),
      )
      .._currentLevel = (fields[0] as num).toInt()
      .._currentExperience = (fields[1] as num).toInt()
      .._nextLevelExperience = (fields[3] as num).toInt();
  }

  @override
  void write(BinaryWriter writer, ExperienceSystem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._currentLevel)
      ..writeByte(1)
      ..write(obj._currentExperience)
      ..writeByte(2)
      ..write(obj.factor)
      ..writeByte(3)
      ..write(obj._nextLevelExperience);
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
