import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event_bus.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/quests/rewards/stat_reward.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/stats/stat_type.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';
import 'package:spoof_finny/models/game_events/complete_task_game_event.dart';
import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
import 'package:spoof_finny/models/game_events/crit_stat_value_game_event.dart';

part 'stat_manager.g.dart';

@HiveType(typeId: 15)
class StatManager extends ChangeNotifier {
  @HiveField(0)
  Map<String, PlayerStat> _stats;
  late GameEventBus _gameEventBus;
  late StreamSubscription onActionHappenSubscription;
  static final Random random = Random();

  StatManager({
    Map<String, PlayerStat>? statsValues,
  }) : _stats = statsValues ?? {};

  void init(GameEventBus gameEventBus){
    _gameEventBus = gameEventBus;
    onActionHappenSubscription = _gameEventBus.onActionHappen.listen((gameEvent) {
      if(gameEvent is CompleteTaskGameEvent){
        for(final reward in gameEvent.rewards.whereType<StatReward>()){
          _changeStat(_stats[reward.stat.name], reward.amount, reward.operator);
        }
      }
      if(gameEvent is ChangeStatValueGameEvent){
        _changeStat(_stats[gameEvent.stat.name], gameEvent.value, gameEvent.operator);
        
        if(gameEvent.stat.name == 'hygiene' && gameEvent.operator == Operator.minus){
          _changeStat(getStat('teethbrush'), gameEvent.value, Operator.plus);
          _changeStat(getStat('shower'), gameEvent.value, Operator.plus);
          _changeStat(getStat('toilet'), gameEvent.value, Operator.plus);
        }

      }
    });

    firstInit();
  }

  List<PlayerStat> get stats => List.unmodifiable(_stats.values);
  List<PlayerStat> get constantStats => List.unmodifiable(_stats.values.where((stat) => stat.type == StatType.constant));

  void updateStat(PlayerStat stat, int value, Operator operator){
    final userStat = _stats[stat.name];
    if(userStat == null){
      return;
    }
    _gameEventBus.actionHappen(ChangeStatValueGameEvent(stat: stat, value: value, operator: operator));
  }

  void removeStat(PlayerStat stat) {
    _stats.remove(stat.name);
    notifyListeners();
    GameState.instance.saveUserInfo();
  }
  void addStat(PlayerStat stat){
    _stats[stat.name] = stat;
    notifyListeners();
    GameState.instance.saveUserInfo();
  }

  PlayerStat getStat(String name){
    final stat = _stats[name];
    if(stat == null) throw Exception('Not found stat: $name');
    return stat;
  }

  PlayerStat getRandomStat() => constantStats[random.nextInt(constantStats.length)];
  

  void _changeStat(PlayerStat? stat, int value, Operator operator){
    if(stat == null) return;
    
    switch(operator){
      case Operator.change:
        stat.currentValue = value;
      case Operator.multi:
        stat.currentValue *= value;
      case Operator.minus:
        stat.currentValue -= value;
      case Operator.plus:
        stat.currentValue += value;
      case Operator.divide:
        stat.currentValue = (stat.currentValue / value).toInt();
    }
    notifyListeners(); 
    GameState.instance.saveUserInfo();
    final state = stat.state();
    if(state == StatValueState.normal) return;
    _gameEventBus.actionHappen(CritStatValueGameEvent(name: stat.name, stat: state));
  }

  void firstInit(){
    if(GameState.instance.userInfo.isInitialized) return;

    addStat(
      PlayerStat(
        name: 'mood',
        displayedName: 'Настроение',
        icon: '🙂',
        type: StatType.constant,
        currentValue: 0
      )
    );
    addStat(
      PlayerStat(
        name: 'satiety',
        displayedName: 'Сытость',
        icon: '😋',
        type: StatType.constant,
        currentValue: 0
      )
    );
    addStat(
      PlayerStat(
        name: 'fatigue',
        displayedName: 'Усталость',
        icon: '🥱',
        type: StatType.constant,
        currentValue: 0
      )
    );
    addStat(
      PlayerStat(
        name: 'hygiene',
        displayedName: 'Гигиена',
        icon: '🧼',
        type: StatType.constant,
        currentValue: 0
      )
    );
    addStat(
      PlayerStat(
        name: 'stress',
        displayedName: 'Стресс',
        icon: '🤯',
        type: StatType.constant,
        currentValue: 0
        )
      );

    addStat(
      PlayerStat(
        name: 'toilet', 
        displayedName: 'Зов природы', 
        icon: '🧻',
        type: StatType.temporary,
        currentValue: 0,
        maxValue: 10,
        minValue: 0,
        critMaxValue: 10
        )
      );
    addStat(
      PlayerStat(
        name: 'shower',
        displayedName: 'Ванять',
        icon: '🚿',
        type: StatType.temporary,
        critMinValue: 0,
        currentValue: 0,
        maxValue: 30,
        minValue: 0,
        critMaxValue: 30
      )
    );
        
    addStat(
      PlayerStat(
        name: 'teethbrush',
        displayedName: 'Зубасто чумазо',
        icon: '🪥',
        type: StatType.temporary,
        critMinValue: 0,
        currentValue: 0,
        maxValue: 20,
        minValue: 0,
        critMaxValue: 20
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    onActionHappenSubscription.cancel();
  }
}