import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import '../../game_events/buy_game_event.dart';
part 'buy_quest_goal.g.dart';

@HiveType(typeId: 33)
class BuyQuestGoal extends QuestGoalProgress {
  @HiveField(4)
  double _totalPrice;
  @HiveField(5)
  double requiredTotalPrice;
  ValueNotifier<double> totalPriceNotifier = ValueNotifier(0.0);
  BuyQuestGoal({
    double totalPrice = 0,
    required this.requiredTotalPrice,
    super.currentValue,
    required super.requiredValue,
    required super.title,
    required super.itemName,
    required super.timeChangedEvent
  }) : _totalPrice = totalPrice;


  @override
  void onEvent(GameEvent action) {
    if(action is! BuyGameEvent || action.itemName != itemName){
      return;
    }
    currentValue += action.count;
    totalPrice += action.totalPrice;
  }

  @override
  bool isCompleted() => currentValue >= requiredValue && totalPrice >= requiredTotalPrice;

  double get totalPrice => _totalPrice;

  set totalPrice(double totalPrice){
    _totalPrice = totalPrice;
    totalPriceNotifier.value = totalPrice;
  }

  @override
  Widget getWidget() {
     return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ValueListenableBuilder<double>(
            valueListenable: totalPriceNotifier,
            builder: (context, currentExperience, child) {
              return LinearProgressIndicator(
                value: progress,
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
                backgroundColor: Colors.grey,
              );
            },
          )
        ),
        ValueListenableBuilder<double>(
          valueListenable: totalPriceNotifier,
          builder: (context, value, child) =>
            Text(
              '$totalPrice/$requiredTotalPrice',
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
        ),
      ],
    );
  }
}