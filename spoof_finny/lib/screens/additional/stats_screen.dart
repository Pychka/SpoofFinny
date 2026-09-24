import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/elements/stat_card.dart';

class StatsScreen extends StatefulWidget{
  const StatsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>{
  @override
  Widget build(BuildContext context) {
    final stats = GameState.instance.userInfo.statManager.stats.values.toList();
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
                Text('Статы', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                IconButton(
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.2, maxHeight: screenHeight * 0.7),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  final stat = stats[index];
                  return StatCard(playerStat: stat);
                },
              )
            )
          ],
        )
      ),
    );
  }
}