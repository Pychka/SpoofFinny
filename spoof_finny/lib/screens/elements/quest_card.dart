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
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Задачи:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Divider(),
                  ListView.separated(
                    itemCount: widget.quest.goals.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), 
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final goal = widget.quest.goals[index];
                      return Row(
                        spacing: 5,
                        children: [
                          Expanded(
                            child: Text(
                              goal.displayedTitle,
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(width: 12),
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
                  Text(
                    'Награды:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
            )
              
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}