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
    return ShopProduct(nameProduct: fields[1] as String)
      .._stockCount = (fields[0] as num).toInt()
      .._price = (fields[2] as num).toDouble()
      .._hasDiscount = fields[3] as bool
      ..markup = (fields[4] as num).toDouble()
      ..priority = (fields[5] as num).toDouble()
      ..minCount = (fields[6] as num).toInt()
      ..maxCount = (fields[7] as num).toInt()
      ..lossRate = (fields[8] as num).toDouble()
      ..supplyRate = (fields[9] as num).toDouble();
  }

  @override
  void write(BinaryWriter writer, ShopProduct obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj._stockCount)
      ..writeByte(1)
      ..write(obj.nameProduct)
      ..writeByte(2)
      ..write(obj._price)
      ..writeByte(3)
      ..write(obj._hasDiscount)
      ..writeByte(4)
      ..write(obj.markup)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.minCount)
      ..writeByte(7)
      ..write(obj.maxCount)
      ..writeByte(8)
      ..write(obj.lossRate)
      ..writeByte(9)
      ..write(obj.supplyRate);
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
