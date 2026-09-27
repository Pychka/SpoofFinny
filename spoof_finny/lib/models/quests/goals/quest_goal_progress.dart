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
  }) : _currentValue = currentValue;

  @HiveField(1)
  String itemName;
  @HiveField(2)
  int _currentValue;
  @HiveField(3)
  int requiredValue;
  ValueNotifier<int> currentValueNotifier = ValueNotifier(0);

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
}