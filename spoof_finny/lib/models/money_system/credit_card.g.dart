// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditCardAdapter extends TypeAdapter<CreditCard> {
  @override
  final typeId = 5;

  @override
  CreditCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditCard()
      ..moneyValue = (fields[0] as num).toDouble()
      .._debt = (fields[1] as num).toDouble();
  }

  @override
  void write(BinaryWriter writer, CreditCard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.moneyValue)
      ..writeByte(1)
      ..write(obj._debt);
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
