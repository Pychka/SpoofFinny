// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingAccountAdapter extends TypeAdapter<SavingAccount> {
  @override
  final int typeId = 9;

  @override
  SavingAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavingAccount(
      payingDay: fields[3] as int,
      money: fields[0] as double,
    )..debt = fields[1] as double;
  }

  @override
  void write(BinaryWriter writer, SavingAccount obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.debt)
      ..writeByte(2)
      ..write(obj.percents)
      ..writeByte(3)
      ..write(obj.payingDay)
      ..writeByte(0)
      ..write(obj.money);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
