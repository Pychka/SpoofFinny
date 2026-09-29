import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
part 'quest_goal_progress.g.dart';

@HiveType(typeId: 30)
class QuestGoalProgress extends QuestGoal{
  
  QuestGoalProgress({
    int currentValue = 0,
    required this.requiredValue,
    required this.itemName,
    required super.title,
    required super.timeChangedEvent,
    required super.id,
  }) : _currentValue = currentValue;

  @HiveField(2)
  String itemName;
  @HiveField(3)
  int _currentValue;
  @HiveField(4)
  int requiredValue;
  ValueNotifier<int> currentValueNotifier = ValueNotifier(0);

  @override
  String get displayedTitle => title
    .replaceAll('{requiredValue}', requiredValue.toString())
    .replaceAll('{itemName}', itemName);

  @override
  void setTarget(double value){
    requiredValue = value.toInt();
  }

  @override
  double get baseValue => requiredValue.toDouble();

  int get currentValue => _currentValue;

  set currentValue(int currentValue){
    _currentValue = currentValue;
    currentValueNotifier.value = currentValue;
  }

  double get progress =>
    (currentValue / requiredValue).clamp(0.0, 1.0);

  @override
  bool isCompleted() => currentValue >= requiredValue;

  @override
  Widget getWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: currentValueNotifier,
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
              '$value/$requiredValue',
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
  QuestGoal get createNew => QuestGoalProgress(id: id, timeChangedEvent: timeChangedEvent, title: title, requiredValue: requiredValue, itemName: itemName);

  @override
  int get hashCode => Object.hash(id, requiredValue, itemName);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is QuestGoalProgress &&
          requiredValue == other.requiredValue &&
          id == other.id &&
          itemName == other.itemName;
}