import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/elements/quest_card.dart';

class TasksScreen extends StatefulWidget{
  const TasksScreen({super.key});
  @override
  State<StatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>{
  int selectedIndex = 1;
  final List<String> _buttons = ['Все', 'Ежедневные', 'Еженедельные', 'Ежемесечные', 'Без срока'];
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
            SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _buttons.length,
                padding: const EdgeInsets.symmetric(horizontal: 4.0), 
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index + 1;
                      });
                    },
                    child: Card(
                        color: index + 1 == selectedIndex ? Colors.blueAccent : Colors.white70,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            _buttons[index],
                            style: TextStyle(
                              color: index + 1 == selectedIndex ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontWeight: index + 1 == selectedIndex ? FontWeight.w900 : FontWeight.normal
                            ),
                          ),
                        ),
                      )
                  );
                }
              ),
            ),
            const Divider(),

            ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.2, maxHeight: screenHeight * 0.7),
              child: ListenableBuilder(
                listenable: GameState.instance.userInfo.questManager,
                builder: (context, child) {
                  final quests = selectedIndex == 2 ? GameState.instance.userInfo.questManager.dailyQuests
                    : selectedIndex == 3 ? GameState.instance.userInfo.questManager.weeklyQuests
                    : selectedIndex == 4 ? GameState.instance.userInfo.questManager.monthlyQuests
                    : selectedIndex == 5 ? GameState.instance.userInfo.questManager.statedQuests
                    : GameState.instance.userInfo.questManager.activeQuests;
                  if(quests.isEmpty){
                    return const SizedBox(
                      height: 100,
                      child: Center(child: Text('Заданий нет 😿', style: TextStyle(fontSize: 30),)),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: quests.length,
                    itemBuilder: (context, index) {
                      final quest = quests[index];
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