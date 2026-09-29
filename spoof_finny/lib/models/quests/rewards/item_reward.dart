import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/user_info.dart';
part 'item_reward.g.dart';

@HiveType(typeId: 44)
class ItemReward extends QuestReward {
  @HiveField(1)
  int count;
  @HiveField(2)
  String name;

  ItemReward({
    required super.id,
    required this.count,
    required this.name,
  });

  @override
  void give(UserInfo userInfo, String name){
    userInfo.inventory.addItem(name, count);
  }
  
  @override
  Widget getWidget() =>
    Text('+$count $name');

  @override
  void init(double target) {
    count = target.toInt();
    name = ItemFactory.instance.getRandomItem().name;
  }

  @override
  double get baseValue => count.toDouble();

  @override
  QuestReward get createNew => ItemReward(id: id, count: count, name: name);

  @override
  int get hashCode => Object.hash(id, count, name);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is ItemReward &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          count == other.count;
}