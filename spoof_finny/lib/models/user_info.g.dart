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
        playerIdValue: fields[2] as String,
        petName: fields[3] as String,
        playerName: fields[6] as String,
        age: (fields[13] as num).toInt(),
        isInitialized: fields[14] as bool,
        experienceSystem: fields[8] as ExperienceSystem?,
        questManager: fields[30] as QuestManager?,
      )
      ..moneyManager = fields[7] as MoneyManager
      ..inventory = fields[9] as Inventory
      ..statManager = fields[10] as StatManager
      ..shopManager = fields[11] as ShopManager
      ..petSprites = (fields[32] as List).cast<PetSprites>();
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.timeManager)
      ..writeByte(1)
      ..write(obj.localeCode)
      ..writeByte(2)
      ..write(obj.playerIdValue)
      ..writeByte(3)
      ..write(obj.petName)
      ..writeByte(6)
      ..write(obj.playerName)
      ..writeByte(7)
      ..write(obj.moneyManager)
      ..writeByte(8)
      ..write(obj.experienceSystem)
      ..writeByte(9)
      ..write(obj.inventory)
      ..writeByte(10)
      ..write(obj.statManager)
      ..writeByte(11)
      ..write(obj.shopManager)
      ..writeByte(13)
      ..write(obj.age)
      ..writeByte(14)
      ..write(obj.isInitialized)
      ..writeByte(30)
      ..write(obj.questManager)
      ..writeByte(32)
      ..write(obj.petSprites);
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
