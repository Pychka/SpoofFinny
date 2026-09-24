import 'package:flutter/material.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';

class StatCard extends StatefulWidget {
  final PlayerStat playerStat;

  const StatCard({
    super.key, 
    required this.playerStat
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  final ExpansibleController _controller = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                widget.playerStat.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: widget.playerStat.currentValueNotifier,
              builder: (BuildContext context, value, Widget? child) { 
                double percent = this.percent(widget.playerStat);
                return Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: percent,
                          borderRadius: BorderRadius.circular(10),
                          color: percent >= 0.5 ? Colors.green : percent >= 0.25 ? Colors.amberAccent : Colors.redAccent,
                          backgroundColor: Colors.grey,
                          minHeight: 30.0,
                        ),
                      ),
                      Text(
                        '${widget.playerStat.currentValue}/${percent >= 0.5 ? widget.playerStat.maxValue : widget.playerStat.minValue}',
                        style: const TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                );
              },
            )
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

  double percent(PlayerStat stat) => (stat.currentValue + stat.minValue.abs()) / (stat.minValue.abs() + stat.maxValue.abs());
}