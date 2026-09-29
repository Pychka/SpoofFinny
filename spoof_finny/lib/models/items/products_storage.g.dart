// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsStorageAdapter extends TypeAdapter<ProductsStorage> {
  @override
  final typeId = 37;

  @override
  ProductsStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsStorage()
      .._storage = (fields[0] as Map).cast<String, ShopProduct>()
      ..nextUpdateTime = fields[1] as GameTime
      ..baseSupplyRate = (fields[2] as num).toDouble()
      ..baseLossRate = (fields[3] as num).toDouble()
      ..warehouseHealth = (fields[4] as num).toDouble();
  }

  @override
  void write(BinaryWriter writer, ProductsStorage obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._storage)
      ..writeByte(1)
      ..write(obj.nextUpdateTime)
      ..writeByte(2)
      ..write(obj.baseSupplyRate)
      ..writeByte(3)
      ..write(obj.baseLossRate)
      ..writeByte(4)
      ..write(obj.warehouseHealth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
