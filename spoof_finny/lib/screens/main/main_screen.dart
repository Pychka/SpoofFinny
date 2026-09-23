import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/additional/tasks_screen.dart';
import 'package:spoof_finny/screens/main/city_screen.dart';
import 'package:spoof_finny/screens/main/home_screen.dart';
import 'package:spoof_finny/screens/main/kitchen_screen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 1;
  late final List<Widget> _screens;

  void changeScreen(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

  @override
  void initState() {
    _screens = [
      GameWidget(game: CityScreen()),
      GameWidget(game: HomeScreen(changeScreen: changeScreen)),
      GameWidget(game: KitchenScreen(changeScreen: changeScreen)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    GameState.instance.userInfo.localeCode = Localizations.localeOf(context).toString();
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
           Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:
              SafeArea(
              child: 
                Padding(
                  padding: EdgeInsetsGeometry.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xA0FFFFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: 
                          SizedBox(
                            width: 50,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.map_outlined),
                                  onPressed: () {

                                  },
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  height: 5,
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
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xA0FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: 
                        Row(
                          spacing: 5,
                          children: [
                            ValueListenableBuilder<double>(
                              valueListenable: GameState.instance.userInfo.moneyManager.wallet.moneyNotifier,
                              builder: (context, value, child) =>
                                Text(
                                  "${GameState.instance.userInfo.moneyManager.wallet.money} 🪙",
                                  style: TextStyle(fontSize: 20),
                                ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 150.0,
                                  height: 30,
                                  child: ValueListenableBuilder<int>(
                                    valueListenable: GameState.instance.userInfo.experienceSystem.currentExperienceNotifier,
                                    builder: (context, currentExperience, child) {
                                      return LinearProgressIndicator(
                                        value: GameState.instance.userInfo.experienceSystem.getPercentOfNextLevel,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.green,
                                        backgroundColor: Colors.grey,
                                      );
                                    },
                                  )
                                ),
                                ValueListenableBuilder<int>(
                                  valueListenable: GameState.instance.userInfo.experienceSystem.currentLevelNotifier,
                                  builder: (context, value, child) =>
                                    Text(
                                      '${GameState.instance.userInfo.experienceSystem.currentLevel} уровень',
                                      style: const TextStyle(
                                        color: Colors.white, 
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xA0FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: 
                        IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () => {
                              
                            },
                          ),
                      ),
                  ],
                ),
                )
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: _currentIndex,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city_outlined),
            activeIcon: Icon(Icons.location_city_sharp),
            label: 'Город'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_sharp),
            label: 'Дом'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            activeIcon: Icon(Icons.food_bank_sharp),
            label: 'Кухня'
          ),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      StorageService.instance.saveUserInfo(GameState.instance.userInfo);
    }
  }
}