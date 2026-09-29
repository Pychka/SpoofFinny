import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/game_events/game_event.dart';
import 'package:spoof_finny/models/items/item_factory.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal_progress.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import '../../game_events/buy_game_event.dart';
part 'buy_quest_goal.g.dart';

@HiveType(typeId: 34)
class BuyQuestGoal extends QuestGoalProgress {
  @HiveField(5)
  double _totalPrice;
  @HiveField(6)
  double requiredTotalPrice;
  ValueNotifier<double> totalPriceNotifier = ValueNotifier(0.0);
  BuyQuestGoal({
    double totalPrice = 0,
    required this.requiredTotalPrice,
    super.currentValue,
    required super.requiredValue,
    required super.title,
    required super.itemName,
    required super.timeChangedEvent,
    required super.id
  }) : _totalPrice = totalPrice;

  @override
  double get baseValue => requiredTotalPrice;

  @override
  void onEvent(GameEvent action) {
    if(action is! BuyGameEvent || action.itemName != itemName){
      return;
    }
    currentValue += action.count;
    totalPrice += action.totalPrice;
  }

  @override
  void setTarget(double value){
    final item = ItemFactory.instance.getRandomItem();
    itemName = item.name;
    requiredTotalPrice = value;
  }

  @override
  double get progress => 
    (totalPrice / requiredTotalPrice).clamp(0.0, 1.0);

  @override
  String get displayedTitle => title
    .replaceAll('{requiredValue}', requiredTotalPrice.toString())
    .replaceAll('{itemName}', itemName);

  @override
  bool isCompleted() => totalPrice >= requiredTotalPrice;

  double get totalPrice => _totalPrice;

  set totalPrice(double totalPrice){
    _totalPrice = totalPrice;
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
              '${totalPrice.toStringAsFixed(2)}/$requiredTotalPrice',
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
  QuestGoal get createNew => BuyQuestGoal(requiredTotalPrice: requiredTotalPrice, requiredValue: requiredValue, title: title, itemName: itemName, timeChangedEvent: timeChangedEvent, id: id);
  
  @override
  int get hashCode => Object.hash(id, requiredTotalPrice, requiredValue, itemName);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is BuyQuestGoal &&
        itemName == other.itemName &&
        requiredTotalPrice == other.requiredTotalPrice &&
        requiredValue == other.requiredValue &&
        id == other.id;
}