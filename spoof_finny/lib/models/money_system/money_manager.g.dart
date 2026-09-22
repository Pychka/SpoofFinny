// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyManagerAdapter extends TypeAdapter<MoneyManager> {
  @override
  final typeId = 13;

  @override
  MoneyManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyManager(
      wallet: fields[0] as Wallet,
      moneyBills: (fields[1] as List).cast<MoneyStorage>(),
    );
  }

  @override
  void write(BinaryWriter writer, MoneyManager obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.wallet)
      ..writeByte(1)
      ..write(obj.moneyBills);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
