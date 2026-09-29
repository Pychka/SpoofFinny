// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopManagerAdapter extends TypeAdapter<ShopManager> {
  @override
  final typeId = 26;

  @override
  ShopManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopManager()
      .._shops = (fields[0] as Map).cast<String, Shop>()
      ..wallet = fields[1] as Wallet
      ..nextUpdateTime = fields[2] as GameTime;
  }

  @override
  void write(BinaryWriter writer, ShopManager obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._shops)
      ..writeByte(1)
      ..write(obj.wallet)
      ..writeByte(2)
      ..write(obj.nextUpdateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
