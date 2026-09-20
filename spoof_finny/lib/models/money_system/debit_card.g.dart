// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebitCardAdapter extends TypeAdapter<DebitCard> {
  @override
  final int typeId = 7;

  @override
  DebitCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebitCard(
      money: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DebitCard obj) {
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
      other is DebitCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
