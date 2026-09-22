// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final typeId = 0;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
        timeManager: fields[0] as GameTimeManager,
        localeCode: fields[1] as String,
        assetsPath: fields[2] as String,
        countFrames: (fields[4] as num).toInt(),
        textureSize: fields[5] as Vector2,
        petName: fields[3] as String,
        playerName: fields[6] as String,
        experienceSystem: fields[8] as ExperienceSystem?,
        inventory: fields[9] == null
            ? const []
            : (fields[9] as List).cast<Item>(),
      )
      ..moneyManager = fields[7] as MoneyManager
      ..statManager = fields[10] as StatManager;
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.timeManager)
      ..writeByte(1)
      ..write(obj.localeCode)
      ..writeByte(2)
      ..write(obj.assetsPath)
      ..writeByte(3)
      ..write(obj.petName)
      ..writeByte(4)
      ..write(obj.countFrames)
      ..writeByte(5)
      ..write(obj.textureSize)
      ..writeByte(6)
      ..write(obj.playerName)
      ..writeByte(7)
      ..write(obj.moneyManager)
      ..writeByte(8)
      ..write(obj.experienceSystem)
      ..writeByte(9)
      ..write(obj.inventory)
      ..writeByte(10)
      ..write(obj.statManager);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
