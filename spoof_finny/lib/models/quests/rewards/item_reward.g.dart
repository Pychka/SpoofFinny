// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_reward.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemRewardAdapter extends TypeAdapter<ItemReward> {
  @override
  final typeId = 44;

  @override
  ItemReward read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemReward(
      id: fields[0] as String,
      count: (fields[1] as num).toInt(),
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemReward obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemRewardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
