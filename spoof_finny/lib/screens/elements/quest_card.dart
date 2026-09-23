import 'package:flutter/material.dart';
import 'package:spoof_finny/models/quests/quest.dart';

class QuestCard extends StatefulWidget {
  final Quest quest;

  const QuestCard({
    super.key, 
    required this.quest
  });

  @override
  State<QuestCard> createState() => _QuestCardState();
}

class _QuestCardState extends State<QuestCard> {
  final ExpansibleController _controller = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.quest.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expansible(
              controller: _controller,
              headerBuilder: (context, animation) {
                return InkWell(
                  onTap: _controller.toggle,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Содержание', style: TextStyle(fontSize: 15)),
                        RotationTransition(
                          turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation),
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ],
                  )
                ));
              },
              bodyBuilder: (context, animation){
                return 
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Описание:'
                        ),
                        const Divider(),
                        Text(
                          widget.quest.description
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Задачи:'
                        ),
                        const Divider(),
                        ListView.builder(
                          itemCount: widget.quest.goals.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(), 
                          itemBuilder: (context, index) {
                            final goal = widget.quest.goals[index];
                            return Row(
                              spacing: 5,
                              children: [
                                Text(goal.title),
                                SizedBox(
                                  width: 80,
                                  height: 30,
                                  child: goal.getWidget(),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Text('Награды:'),
                        const Divider(),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.quest.rewards.length,
                            padding: const EdgeInsets.symmetric(horizontal: 4.0), 
                            itemBuilder: (context, index) {
                              return Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                      child: widget.quest.rewards[index].getWidget(),
                                    ),
                                  )
                                );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
              },
            ),
              
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}