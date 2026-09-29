// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_sprites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetSpritesAdapter extends TypeAdapter<PetSprites> {
  @override
  final typeId = 51;

  @override
  PetSprites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetSprites(
      width: (fields[0] as num).toInt(),
      height: (fields[1] as num).toInt(),
      path: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PetSprites obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.width)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetSpritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
