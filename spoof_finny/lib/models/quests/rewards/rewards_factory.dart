import 'dart:math';
import 'package:spoof_finny/models/quests/rewards/experience_reward.dart';
import 'package:spoof_finny/models/quests/rewards/item_reward.dart';
import 'package:spoof_finny/models/quests/rewards/money_reward.dart';
import 'package:spoof_finny/models/quests/rewards/quest_reward.dart';
import 'package:spoof_finny/models/quests/rewards/stat_reward.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/stats/stat_type.dart';

class RewardsFactory {
  final Map<String, QuestReward> _factories = {};
  static final Random random = Random();
  RewardsFactory._internal();

  List<QuestReward> get goals => List.unmodifiable(_factories.values);

  QuestReward getRandomTypedQuestReward<T extends QuestReward>(){
    final goals = _factories.values.whereType<T>().toList();
    return goals[random.nextInt(goals.length)].createNew;
  }

  QuestReward getRandomQuestReward() =>
    goals[random.nextInt(goals.length)].createNew;

  static final RewardsFactory instance = RewardsFactory._internal();

  List<QuestReward> get getGoals => List.unmodifiable(_factories.values);

  QuestReward get(String name, int count){
    final quest = _factories[name];

    if (quest == null) {
      throw Exception("Not found factory by key: $name");
    }

    return quest.createNew;
  }

  void register(QuestReward item) =>
    _factories[item.id] = item;

  void init(){
    register(
      ExperienceReward(
        id: 'reward_exp',
        amount: 20
      )
    );
    register(
      MoneyReward(
        id: 'reward_money',
        amount: 10
      )
    );
    register(
      ItemReward(
        id: 'reward_item',
        name: '',
        count: 1
      )
    );
    register(
      StatReward(
        id: 'reward_stat_multi',
        amount: 1,
        stat: PlayerStat(displayedName: 'displayedName', name: 'name', icon: 'icon', type: StatType.constant),
        operator: Operator.multi
      )
    );
    register(
      StatReward(
        id: 'reward_stat_plus',
        amount: 5,
        stat: PlayerStat(displayedName: 'displayedName', name: 'name', icon: 'icon', type: StatType.constant),
        operator: Operator.plus
      )
    );
    register(
      StatReward(
        id: 'reward_stat_minus',
        amount: 2,
        stat: PlayerStat(displayedName: 'displayedName', name: 'name', icon: 'icon', type: StatType.constant),
        operator: Operator.minus
      )
    );
    
  }
}