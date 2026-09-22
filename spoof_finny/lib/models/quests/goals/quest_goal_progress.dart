import 'package:flutter/material.dart';
import 'package:spoof_finny/models/quests/goals/quest_goal.dart';

class QuestGoalProgress extends QuestGoal{
  
  QuestGoalProgress({
    required this._currentValue,
    required this.requiredValue,
    required this.itemName,
    required super.title
  }){
    currentValue = _currentValue;
  }
  
  final String itemName;
  int _currentValue;
  final int requiredValue;
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
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ValueListenableBuilder<int>(
            valueListenable: currentValueNotifier,
            builder: (context, currentExperience, child) {
              return LinearProgressIndicator(
                value: progress,
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
                backgroundColor: Colors.grey,
                minHeight: double.infinity,
              );
            },
          )
        ),
        ValueListenableBuilder<int>(
          valueListenable: currentValueNotifier,
          builder: (context, value, child) =>
            Text(
              '$currentValue/$requiredValue',
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