// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopProductAdapter extends TypeAdapter<ShopProduct> {
  @override
  final typeId = 27;

  @override
  ShopProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopProduct(item: fields[1] as Item)
      .._stockCount = (fields[0] as num).toInt()
      .._price = (fields[2] as num).toDouble()
      .._hasDiscount = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, ShopProduct obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._stockCount)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj._price)
      ..writeByte(3)
      ..write(obj._hasDiscount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
