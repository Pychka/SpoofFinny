import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/elements/quest_card.dart';

class TasksScreen extends StatefulWidget{
  const TasksScreen({super.key});
  @override
  State<StatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>{
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Задания', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                IconButton(
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(),

            ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.2, maxHeight: screenHeight * 0.7),
              child: ListenableBuilder(
                listenable: GameState.instance.questManager,
                builder: (context, child) {
                  if(GameState.instance.questManager.activeQuests.isEmpty){
                    return const SizedBox(
                      height: 100,
                      child: Center(child: Text('Заданий нет 😿', style: TextStyle(fontSize: 30),)),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: GameState.instance.questManager.activeQuests.length,
                    itemBuilder: (context, index) {
                      final quest = GameState.instance.questManager.activeQuests[index];
                      return QuestCard(quest: quest);
                    },
                  );
                }
              )
            )
          ],
        )
      ),
    );
  }
}