import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import '../../game_events/buy_game_event.dart';
part 'money_quest_goal.g.dart';

@HiveType(typeId: 47)
class MoneyQuestGoal extends QuestGoalProgress {
  @HiveField(5)
  double _totalValue;
  @HiveField(6)
  double requiredTotalValue;
  ValueNotifier<double> totalPriceNotifier = ValueNotifier(0.0);
  MoneyQuestGoal({
    double totalPrice = 0,
    required this.requiredTotalValue,
    super.currentValue,
    required super.requiredValue,
    required super.title,
    required super.itemName,
    required super.timeChangedEvent,
    required super.id
  }) : _totalValue = totalPrice;

  @override
  void setTarget(double value){
    requiredTotalValue = value;
  }

  @override
  void onEvent(GameEvent action) {
    if(action is! BuyGameEvent || action.itemName != itemName){
      return;
    }
    currentValue += action.count;
    totalPrice += action.totalPrice;
  }

  @override
  String get displayedTitle => title
    .replaceAll('{requiredValue}', requiredTotalValue.toString())
    .replaceAll('{itemName}', itemName);

  @override
  double get baseValue => requiredTotalValue;

  @override
  bool isCompleted() => totalPrice >= requiredTotalValue;

  double get totalPrice => _totalValue;

  set totalPrice(double totalPrice){
    _totalValue = totalPrice;
    totalPriceNotifier.value = totalPrice;
  }

  @override
  Widget getWidget() {
        return ValueListenableBuilder<double>(
      valueListenable: totalPriceNotifier,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
                backgroundColor: Colors.grey,
                minHeight: double.infinity,
              ),
            ),
            Text(
              '${totalPrice.toStringAsFixed(2)}/$requiredTotalValue',
              style: const TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }
  @override
  QuestGoal get createNew => MoneyQuestGoal(requiredTotalValue: requiredTotalValue, requiredValue: requiredValue, title: title, itemName: itemName, timeChangedEvent: timeChangedEvent, id: id);

  @override
  int get hashCode => Object.hash(id, requiredTotalValue, requiredValue, itemName);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is MoneyQuestGoal &&
        itemName == other.itemName &&
        requiredTotalValue == other.requiredTotalValue &&
        requiredValue == other.requiredValue &&
        id == other.id;
}