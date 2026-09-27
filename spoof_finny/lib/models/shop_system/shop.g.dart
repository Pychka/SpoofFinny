// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopAdapter extends TypeAdapter<Shop> {
  @override
  final typeId = 25;

  @override
  Shop read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shop(
      name: fields[1] as String,
      assetPath: fields[2] as String,
      headerPath: fields[3] as String,
      relativeX: (fields[4] as num).toDouble(),
      relativeY: (fields[5] as num).toDouble(),
      relativeWidth: (fields[6] as num).toDouble(),
      relativeHeight: (fields[7] as num).toDouble(),
    ).._products = (fields[0] as Map).cast<String, ShopProduct>();
  }

  @override
  void write(BinaryWriter writer, Shop obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._products)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.assetPath)
      ..writeByte(3)
      ..write(obj.headerPath)
      ..writeByte(4)
      ..write(obj.relativeX)
      ..writeByte(5)
      ..write(obj.relativeY)
      ..writeByte(6)
      ..write(obj.relativeWidth)
      ..writeByte(7)
      ..write(obj.relativeHeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
