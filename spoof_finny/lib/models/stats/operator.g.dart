// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperatorAdapter extends TypeAdapter<Operator> {
  @override
  final typeId = 23;

  @override
  Operator read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Operator.minus;
      case 1:
        return Operator.plus;
      case 2:
        return Operator.change;
      case 3:
        return Operator.multi;
      case 4:
        return Operator.divide;
      default:
        return Operator.minus;
    }
  }

  @override
  void write(BinaryWriter writer, Operator obj) {
    switch (obj) {
      case Operator.minus:
        writer.writeByte(0);
      case Operator.plus:
        writer.writeByte(1);
      case Operator.change:
        writer.writeByte(2);
      case Operator.multi:
        writer.writeByte(3);
      case Operator.divide:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
