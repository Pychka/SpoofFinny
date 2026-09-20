// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditCardAdapter extends TypeAdapter<CreditCard> {
  @override
  final int typeId = 5;

  @override
  CreditCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditCard(
      money: fields[0] as double,
    )..debt = fields[1] as double;
  }

  @override
  void write(BinaryWriter writer, CreditCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.debt)
      ..writeByte(2)
      ..write(obj.limit)
      ..writeByte(3)
      ..write(obj.dailyInterestRate)
      ..writeByte(0)
      ..write(obj.money);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
