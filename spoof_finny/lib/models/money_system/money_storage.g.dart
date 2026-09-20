// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyStorageAdapter extends TypeAdapter<MoneyStorage> {
  @override
  final int typeId = 4;

  @override
  MoneyStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyStorage(
      money: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MoneyStorage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.money);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
