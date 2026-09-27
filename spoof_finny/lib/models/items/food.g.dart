// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodAdapter extends TypeAdapter<Food> {
  @override
  final typeId = 24;

  @override
  Food read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Food(
      name: fields[0] as String,
      assetsFolder: fields[4] as String,
      events: fields[3] == null
          ? const []
          : (fields[3] as List).cast<ChangeStatValueGameEvent>(),
      countValue: fields[2] == null ? 0 : (fields[2] as num).toInt(),
      canStack: fields[1] == null ? true : fields[1] as bool,
      basePrice: (fields[5] as num).toDouble(),
      timeChangedEvent: fields[99] as GameTimeChangedEvent,
    );
  }

  @override
  void write(BinaryWriter writer, Food obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.canStack)
      ..writeByte(2)
      ..write(obj.countValue)
      ..writeByte(3)
      ..write(obj.events)
      ..writeByte(4)
      ..write(obj.assetsFolder)
      ..writeByte(5)
      ..write(obj.basePrice)
      ..writeByte(99)
      ..write(obj.timeChangedEvent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
