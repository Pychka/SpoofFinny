import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/additional/bills_screen.dart';
import 'package:spoof_finny/screens/additional/settings_screen.dart';
import 'package:spoof_finny/screens/additional/stats_screen.dart';
import 'package:spoof_finny/screens/additional/tasks_screen.dart';

class TopMainMenu extends StatefulWidget{
  const TopMainMenu({required this.changeScreen, super.key});

  final Function(int) changeScreen;

  @override
  State<StatefulWidget> createState() => _TopMainMenuState();
}

class _TopMainMenuState extends State<TopMainMenu> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child:
        SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  margin: EdgeInsets.all(5),
                  color: Color(0xA0FFFFFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: 
                    SizedBox(
                      width: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.map_outlined),
                            onPressed: () {
                              widget.changeScreen(1);
                            },
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                            height: 2,
                            indent: 8,
                            endIndent: 8,
                          ),
                          IconButton(
                            icon: const Icon(Icons.task_alt_outlined),
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return const TasksScreen();
                                }
                              );
                            }
                          ),
                        ],
                      ),
                    )
                  ),
                  Expanded(
                    child: Card(
                    color: Color(0xA0FFFFFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Row(
                            spacing: 5,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return const BillsScreen();
                                    }
                                  );
                                },
                                child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.25,
                                ),
                                child: ValueListenableBuilder<double>(
                                  valueListenable: GameState.instance.userInfo.moneyManager.wallet.moneyNotifier,
                                  builder: (context, value, child) => Text(
                                      "${value % 1 == 0 ? value.toInt() : value.toStringAsFixed(2)}🪙",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return const StatsScreen();
                                      }
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:ValueListenableBuilder<int>(
                                          valueListenable: GameState.instance.userInfo.experienceSystem.currentExperienceNotifier,
                                          builder: (context, currentExperience, child) {
                                            return Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                LinearProgressIndicator(
                                                  value: GameState.instance.userInfo.experienceSystem.getPercentOfNextLevel,
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.green,
                                                  minHeight: 30,
                                                  backgroundColor: Colors.grey,
                                                ),
                                                Text(
                                                  '$currentExperience/${GameState.instance.userInfo.experienceSystem.nextLevelExperience}',
                                                  style: const TextStyle(
                                                    color: Colors.white, 
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ]
                                            );
                                          }
                                        )
                                      ),
                                      SizedBox(width: 5,),
                                      ValueListenableBuilder<int>(
                                        valueListenable: GameState.instance.userInfo.experienceSystem.currentLevelNotifier,
                                        builder: (context, value, child) =>
                                          Text(
                                            '${GameState.instance.userInfo.experienceSystem.currentLevel}⭐',
                                            style: const TextStyle(
                                              color: Colors.black, 
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                          )
                                        )
                                      ]
                                    )
                                  )
                              )
                            ],
                          ),
                        ),
                      
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    color: Color(0xA0FFFFFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: SizedBox(
                      width: 50,
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () => {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return const SettingsScreen();
                                }
                              )
                            },
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                            height: 2,
                            indent: 8,
                            endIndent: 8,
                          ),
                          SizedBox(
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: ValueListenableBuilder<int>(
                                valueListenable: GameState.instance.userInfo.timeManager.currentGameTime.totalSecondsValueNotifier,
                                builder: (context, value, child) =>
                                  Text(
                                    GameState.instance.userInfo.timeManager.currentGameTime.formatShortTime,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black, 
                                      fontSize: 17,
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ) 
            ],
          ),
        )
      ),
    );
  }
}